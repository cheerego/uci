package host

import (
	"context"
	"fmt"
	"github.com/cheerego/uci/app/cli/internal/config"
	"github.com/cheerego/uci/frame/flow"
	"github.com/cheerego/uci/frame/protocol/letter"
	"github.com/cheerego/uci/pkg/log"
	"github.com/docker/docker/api/types"
	"github.com/robertkrimen/otto"
	"go.uber.org/zap"
	"gopkg.in/yaml.v2"
	"io"
	"os"
	"os/exec"
	"path"
	"strings"
)

type HostExecutor struct {
}

func NewHostExecutor() *HostExecutor {
	return &HostExecutor{}
}

type Runtime struct {
	Workspace string
	Envs      map[string]string
	RawWriter io.WriteCloser
}

func NewRuntime(workspace string, envs map[string]string, rawWriter io.WriteCloser) *Runtime {
	return &Runtime{Workspace: workspace, Envs: envs, RawWriter: rawWriter}
}

func (h *HostExecutor) PrepareWorkspace(payload *letter.StartPipelinePayload) (string, error) {
	taskWorkspaceDir, err := config.UciPipelineWorkspaceDir(payload.WorkflowId, payload.PipelineId, payload.Salt)
	if err != nil {
		return "", err
	}
	err = os.MkdirAll(taskWorkspaceDir, 0755)
	if err != nil {
		log.Error("mkdir workspace dir err", zap.Error(err))
		return "", err
	}
	return taskWorkspaceDir, nil
}

func (h *HostExecutor) PrepareEnviron(envs map[string]string) []string {
	// 操作系统变量
	se := os.Environ()
	// 下发下来的变量
	pe := make([]string, len(envs))
	for key, value := range envs {
		pe = append(pe, fmt.Sprintf("%s=%s", key, value))
	}
	t := make([]string, len(se)+len(pe))
	t = append(t, se...)
	t = append(t, pe...)
	return pe
}

func (h *HostExecutor) Start(stopCtx context.Context, payload *letter.StartPipelinePayload, raw io.WriteCloser) error {
	var flower flow.Flow
	err := yaml.Unmarshal([]byte(payload.Yaml), &flower)
	if err != nil {
		return err
	}
	log.Info("flow ", zap.Any("flow", flower))

	workspaceDir, err := h.PrepareWorkspace(payload)
	if err != nil {
		log.Error("prepare workspace err", zap.String("pipeline", payload.String()), zap.Error(err))
		return err
	}

	log.Infof("pipeline %s workspace %s", payload.String(), workspaceDir)

	return h.RunFlow(stopCtx, NewRuntime(workspaceDir, payload.Envs, raw), &flower)
}

func (h *HostExecutor) RunFlow(ctx context.Context, runtime *Runtime, f *flow.Flow) error {
	log.Info("job len", zap.Int("len", len(f.Jobs)))
	for _, job := range f.Jobs {
		err := h.RunJob(ctx, runtime, f, job)
		if err != nil {
			return err
		}
	}
	return nil
}

func (h *HostExecutor) RunJob(stopCtx context.Context, runtime *Runtime, f *flow.Flow, j *flow.Job) error {
	if j.If != "" {
		vm := otto.New()
		vm.Set("env", runtime.Envs)
		value, err := vm.Run(j.If)
		if err != nil {
			return err
		}
		b, err := value.ToBoolean()
		if err != nil {
			return err
		}
		if !b {
			return nil
		}
	}
	//
	if j.Docker.Image != "" {
		err := func() error {
			docker, err := Docker()
			if err != nil {
				return err
			}
			pull, err := docker.ImagePull(context.Background(), j.Docker.Image, types.ImagePullOptions{})
			if err != nil {
				return err
			}
			defer pull.Close()

			io.Copy(runtime.RawWriter, pull)
			return err
		}()
		if err != nil {
			return err
		}
	}

	for _, step := range j.Steps {
		err := h.RunStep(stopCtx, runtime, f, j, step)
		if err != nil {
			return err
		}
	}
	return nil
}

func (h *HostExecutor) RunStep(stopCtx context.Context, runtime *Runtime, f *flow.Flow, j *flow.Job, s *flow.Step) error {
	var shell string = "sh"
	if j.Defaults.Run.Shell != "" {
		shell = j.Defaults.Run.Shell
	}
	var workspace = runtime.Workspace
	if j.Defaults.Run.WorkingDirectory != "" {
		workspace = path.Join(workspace, j.Defaults.Run.WorkingDirectory)
	}

	cmd := exec.CommandContext(stopCtx, shell, "-c", "-e", strings.Replace(*s.Run, "\r\n", "\n", -1))
	cmd.Env = h.PrepareEnviron(runtime.Envs)
	cmd.Dir = workspace
	cmd.Stdout = runtime.RawWriter
	cmd.Stderr = runtime.RawWriter
	if err := cmd.Start(); err != nil {
		return err
	}
	return cmd.Wait()

}

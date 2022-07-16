package host

import (
	"context"
	"fmt"
	"github.com/cheerego/uci/app/cli/internal/config"
	"github.com/cheerego/uci/app/cli/internal/executor/storage"
	"github.com/cheerego/uci/frame/flow"
	"github.com/cheerego/uci/frame/protocol/letter"
	"github.com/cheerego/uci/pkg/log"
	"github.com/docker/docker/api/types"
	"github.com/robertkrimen/otto"
	"go.uber.org/zap"
	"golang.org/x/sync/errgroup"
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

func (h *HostExecutor) PrepareWorkspace(payload *letter.StartPipelinePayload) (string, error) {
	taskWorkspaceDir, err := config.UciPipelineWorkspaceDir(payload.WorkflowId, payload.PipelineId, payload.Salt)
	if err != nil {
		return "", err
	}
	err = os.MkdirAll(taskWorkspaceDir, 0755)
	if err != nil {
		log.S().Error("mkdir workspace dir err", zap.Error(err))
		return "", err
	}
	return taskWorkspaceDir, nil
}

func (h *HostExecutor) PrepareEnviron(payload *letter.StartPipelinePayload) []string {
	// 操作系统变量
	se := os.Environ()
	// 下发下来的变量
	pe := make([]string, len(payload.Envs))
	for key, value := range payload.Envs {
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
	log.L().Info("flow ", zap.Any("flow", flower))

	workspaceDir, err := h.PrepareWorkspace(payload)
	if err != nil {
		log.L().Error("prepare workspace err", zap.String("pipeline", payload.String()), zap.Error(err))
		return err
	}

	log.S().Infof("pipeline %s workspace %s", payload.String(), workspaceDir)

	return h.RunFlowRuntime(stopCtx, flow.NewFlowRuntime(&flower, payload, workspaceDir, raw))
}

func (h *HostExecutor) RunFlowRuntime(ctx context.Context, f *flow.FlowRuntime) error {
	for _, job := range f.Flow.Jobs {
		return func() error {
			jobRuntime := flow.NewJobRuntime(f, job)
			defer jobRuntime.JobReader.Close()
			err := h.RunJobRuntime(ctx, jobRuntime)
			if err != nil {
				return err
			}
			return nil
		}()
	}
	return nil
}

func (h *HostExecutor) RunJobRuntime(stopCtx context.Context, j *flow.JobRuntime) error {
	if j.Job.If != "" {
		vm := otto.New()
		vm.Set("env", j.Runtime.Payload.Envs)
		value, err := vm.Run(j.Job.If)
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
	if j.Job.RunsOn != "" {
		err := func() error {
			docker, err := Docker()
			if err != nil {
				return err
			}
			pull, err := docker.ImagePull(context.Background(), j.Job.RunsOn, types.ImagePullOptions{})
			if err != nil {
				return err
			}
			defer pull.Close()

			io.Copy(io.MultiWriter(j.Runtime.FlowWriter, j.JobWriter), pull)
			return err
		}()
		if err != nil {
			return err
		}
	}

	for _, step := range j.Job.Steps {
		err := h.RunStep(stopCtx, flow.NewStepRuntime(j.Runtime, j, step))
		if err != nil {
			return err
		}
	}
	return nil
}

func (h *HostExecutor) RunStep(stopCtx context.Context, s *flow.StepRuntime) error {
	log.S().Infof("run step")

	r := s.JobRuntime.JobReader
	w := s.JobRuntime.JobWriter

	g, _ := errgroup.WithContext(stopCtx)
	var shell string = "sh"
	if s.Job.Defaults.Run.Shell != "" {
		shell = s.Job.Defaults.Run.Shell
	}
	var workspace = s.Runtime.Workspace
	if s.Job.Defaults.Run.WorkingDirectory != "" {
		workspace = path.Join(workspace, s.Job.Defaults.Run.WorkingDirectory)
	}

	g.Go(func() error {
		defer w.Close()
		cmd := exec.CommandContext(stopCtx, shell, "-c", "-e", strings.Replace(*s.Step.Run, "\r\n", "\n", -1))
		cmd.Env = h.PrepareEnviron(s.Runtime.Payload)
		cmd.Dir = workspace
		mw := io.MultiWriter(s.Runtime.FlowWriter, w)
		cmd.Stdout = mw
		cmd.Stderr = mw
		if err := cmd.Start(); err != nil {
			return err
		}
		return cmd.Wait()
	})

	g.Go(func() error {
		return storage.StepLog(s.Runtime.Payload, r)
	})
	return g.Wait()
}

package executor

import (
	"context"
	"fmt"
	"github.com/cheerego/uci/app/cli/internal/config"
	"github.com/cheerego/uci/flow"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cheerego/uci/protocol/letter"
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

var _ IExecutor = (*HostExecutor)(nil)

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

func (h *HostExecutor) Start(stopCtx context.Context, payload *letter.StartPipelinePayload, raw io.Writer) error {
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
	return h.RunJobs(stopCtx, workspaceDir, payload, &flower, raw)
}

func (h *HostExecutor) RunJobs(ctx context.Context, workspace string, payload *letter.StartPipelinePayload, f *flow.Flow, raw io.Writer) error {
	for _, job := range f.Jobs {
		err := h.RunSteps(ctx, workspace, payload, job, raw)
		if err != nil {
			return err
		}
	}
	return nil
}

func (h *HostExecutor) RunSteps(ctx context.Context, workspace string, payload *letter.StartPipelinePayload, job flow.Job, raw io.Writer) error {
	for _, step := range job.Steps {
		err := h.RunStep(ctx, workspace, payload, job, step, raw)
		if err != nil {
			return err
		}
	}
	return nil

}

func (h *HostExecutor) RunStep(stopCtx context.Context, workspace string, payload *letter.StartPipelinePayload, job flow.Job, step flow.Step, raw io.Writer) error {
	r, w, err := os.Pipe()
	if err != nil {
		return err
	}
	defer r.Close()

	g, _ := errgroup.WithContext(stopCtx)
	var shell string = "sh"
	if job.Defaults.Run.Shell != "" {
		shell = job.Defaults.Run.Shell
	}
	if job.Defaults.Run.WorkingDirectory != "" {
		workspace = path.Join(workspace, job.Defaults.Run.WorkingDirectory)
	}

	g.Go(func() error {
		defer w.Close()
		cmd := exec.CommandContext(stopCtx, shell, "-c", "-e", strings.Replace(*step.Run, "\r\n", "\n", -1))
		cmd.Env = h.PrepareEnviron(payload)
		cmd.Dir = workspace
		mw := io.MultiWriter(raw, w)
		cmd.Stdout = mw
		cmd.Stderr = mw
		err = cmd.Start()
		if err != nil {
			return err
		}
		return cmd.Wait()
	})

	g.Go(func() error {
		return stepLog(payload, r)
	})
	return g.Wait()
}

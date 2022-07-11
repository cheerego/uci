package executor

import (
	"context"
	"fmt"
	"github.com/cheerego/uci/app/cli/internal/config"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cheerego/uci/protocol/letter"
	"go.uber.org/zap"
	"io"
	"os"
	"os/exec"
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

func (h *HostExecutor) Start(ctx context.Context, payload *letter.StartPipelinePayload, w io.Writer) error {

	workspaceDir, err := h.PrepareWorkspace(payload)
	if err != nil {
		log.L().Error("prepare workspace err", zap.String("pipeline", payload.String()), zap.Error(err))
		return err
	}

	log.L().Info("pipeline dir", zap.String("pipeline", payload.String()), zap.String("pipelineWorkspace", workspaceDir))
	cmd := exec.CommandContext(ctx, "sh", "-c", "-e", strings.Replace(payload.Yaml, "\r\n", "\n", -1))

	cmd.Env = h.PrepareEnviron(payload)
	cmd.Dir = workspaceDir

	cmd.Stdout = w
	cmd.Stderr = w
	err = cmd.Start()
	if err != nil {
		return err
	}
	return cmd.Wait()
}

package executor

import (
	"context"
	"fmt"
	"github.com/cheerego/uci/app/cli/internal/collector"
	"github.com/cheerego/uci/app/cli/internal/config/dir"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cheerego/uci/protocol/letter"
	"go.uber.org/zap"
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

func (h *HostExecutor) PrepareWorkspace(payload *letter.StartPipelinePayload) error {
	err := os.MkdirAll(dir.UciTaskWorkspaceDir(payload.WorkflowId, payload.PipelineId, payload.Salt), 0755)
	if err != nil {
		log.S().Error("mkdir workspace dir err", zap.Error(err))
		return err
	}

	p := dir.UciTaskLogPath(payload.WorkflowId, payload.PipelineId, payload.Salt)
	err = os.MkdirAll(path.Dir(p), 0755)
	if err != nil {
		log.L().Error("mkdir err", zap.String("path", path.Dir(p)), zap.Error(err))
		return err
	}
	return nil
}
func (h *HostExecutor) PrepareRawLog(payload *letter.StartPipelinePayload) (*os.File, error) {
	p := dir.UciTaskLogPath(payload.WorkflowId, payload.PipelineId, payload.Salt)
	file, err := os.OpenFile(p, os.O_RDWR|os.O_APPEND|os.O_CREATE, 0644)
	if err != nil {
		log.S().Error("openfile err", zap.Error(err))
		return nil, err
	}
	return file, nil
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

func (h *HostExecutor) Start(ctx context.Context, payload *letter.StartPipelinePayload) error {

	err := h.PrepareWorkspace(payload)
	if err != nil {
		log.L().Error("prepare workspace err", zap.String("pipeliner", payload.LogName()), zap.Error(err))
		return err
	}
	log.L().Info("pipeliner dir", zap.String("pipeliner", payload.LogName()), zap.String("dir", dir.UciPipelineDir(payload.WorkflowId, payload.PipelineId, payload.Salt)))

	workspaceDir := dir.UciTaskWorkspaceDir(payload.WorkflowId, payload.PipelineId, payload.Salt)

	cmd := exec.Command("sh", "-c", "-e", strings.Replace(payload.Yaml, "\r\n", "\n", -1))

	cmd.Env = h.PrepareEnviron(payload)
	cmd.Dir = workspaceDir
	stdPipe, err := cmd.StdoutPipe()
	if err != nil {
		return err
	}
	defer stdPipe.Close()
	cmd.Stderr = cmd.Stdout
	err = cmd.Start()
	if err != nil {
		log.S().Error("exec start err", zap.String("pipeliner", payload.LogName()), zap.Error(err))
		return err
	}
	collector.NewCollector().CollectorRawlog(ctx, payload, stdPipe)
	return cmd.Wait()
}

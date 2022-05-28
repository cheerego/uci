package executor

import (
	"bufio"
	"fmt"
	"github.com/cheerego/uci/app/cli/internal/config/dir"
	"github.com/cheerego/uci/protocol/letter/payload"
	"go.uber.org/zap"
	"os"
	"os/exec"
	"path"
)

type HostExecutor struct {
}

func NewHostExecutor() *HostExecutor {
	return &HostExecutor{}
}

var _ IExecutor = (*HostExecutor)(nil)

func (h *HostExecutor) PrepareWorkspace(payload *payload.StartPipelinePayload) error {
	err := os.MkdirAll(dir.UciTaskWorkspaceDir(payload.WorkflowId, payload.PipelineId, payload.Salt), 0755)
	if err != nil {
		zap.S().Error("mkdir workspace dir err", zap.Error(err))
		return err
	}

	p := dir.UciTaskLogPath(payload.WorkflowId, payload.PipelineId, payload.Salt)
	err = os.MkdirAll(path.Dir(p), 0755)
	if err != nil {
		zap.L().Error("mkdir err", zap.String("path", path.Dir(p)), zap.Error(err))
		return err
	}
	return nil
}
func (h *HostExecutor) PrepareRawLog(payload *payload.StartPipelinePayload) (*os.File, error) {
	p := dir.UciTaskLogPath(payload.WorkflowId, payload.PipelineId, payload.Salt)
	file, err := os.OpenFile(p, os.O_RDWR|os.O_APPEND|os.O_CREATE, 0644)
	if err != nil {
		zap.S().Error("openfile err", zap.Error(err))
		return nil, err
	}
	return file, nil
}

func (h *HostExecutor) PrepareEnviron(payload *payload.StartPipelinePayload) []string {
	se := os.Environ()
	//pe := make([]string, len(payload.Envs))
	//for key, value := range payload.Envs {
	//	pe = append(pe, fmt.Sprintf("%s=%s", key, value))
	//}
	//t := make([]string, len(se)+len(pe))
	//t = append(t, se...)
	//t = append(t, pe...)
	return se
}

func (h *HostExecutor) Start(payload *payload.StartPipelinePayload) {

	err := h.PrepareWorkspace(payload)
	if err != nil {
		zap.L().Error("prepare workspace err", zap.Error(err))
		return
	}

	workspaceDir := dir.UciTaskWorkspaceDir(payload.WorkflowId, payload.PipelineId, payload.Salt)
	cmd := exec.Command("sh", "-c", fmt.Sprintf("UCI=UCI && WORKSPACE=%s &&  %s", workspaceDir, payload.Yaml))
	cmd.Env = h.PrepareEnviron(payload)
	cmd.Dir = workspaceDir
	file, err := h.PrepareRawLog(payload)
	if err != nil {
		return
	}
	defer file.Close()
	writer := bufio.NewWriter(file)
	cmd.Stdout = writer
	cmd.Stderr = writer

	err = cmd.Start()
	if err != nil {
		zap.S().Error("exec start err", zap.Error(err))
		return
	}
	cmd.Wait()
}

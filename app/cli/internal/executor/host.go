package executor

import (
	"bufio"
	"fmt"
	"github.com/cheerego/uci/app/cli/internal/config/dir"
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

func (h *HostExecutor) Start(taskName, payload string) error {
	err := os.MkdirAll(dir.UciTaskWorkspaceDir(taskName), 0755)
	if err != nil {
		zap.S().Error("mkdir workspace dir err", zap.Error(err))
		return err
	}

	p := dir.UciTaskLogPath(taskName)
	err = os.MkdirAll(path.Dir(p), 0755)
	if err != nil {
		zap.L().Error("mkdir err", zap.String("path", path.Dir(p)), zap.Error(err))
		return err
	}

	cmd := exec.Command("sh", "-c", fmt.Sprintf("UCI=UCI && %s", payload))
	cmd.Env = os.Environ()
	cmd.Dir = dir.UciTaskWorkspaceDir(taskName)

	file, err := os.OpenFile(p, os.O_RDWR|os.O_APPEND|os.O_CREATE, 0644)
	if err != nil {
		zap.S().Error("openfile err", zap.Error(err))
		return err
	}
	defer file.Close()
	writer := bufio.NewWriter(file)
	cmd.Stdout = writer
	cmd.Stderr = writer

	err = cmd.Start()
	if err != nil {
		zap.S().Error("exec start err", zap.Error(err))
		return err
	}
	return cmd.Wait()
}

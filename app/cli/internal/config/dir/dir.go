package dir

import (
	"fmt"
	"github.com/cheerego/uci/app/cli/internal/config"
	"github.com/mitchellh/go-homedir"
	"path"
)

func HomeDir() string {
	dir, _ := homedir.Dir()
	return dir
}

func UciConfigPath() string {
	return path.Join(HomeDir(), "uci.conf")
}

func UciDir() string {
	return path.Join(HomeDir(), fmt.Sprintf(".%s", config.Name))
}

func UciPipelineDir(workflowId uint32, pipelineId uint32, salt string) string {
	return path.Join(UciDir(), fmt.Sprintf("workflow-%d-pipeline-%d-%s", workflowId, pipelineId, salt))
}

func UciTaskWorkspaceDir(workflowId uint32, pipelineId uint32, salt string) string {
	return path.Join(UciPipelineDir(workflowId, pipelineId, salt), "workspace")
}

func UciTaskLogPath(workflowId uint32, pipelineId uint32, salt string) string {
	return path.Join(UciPipelineDir(workflowId, pipelineId, salt), "raw.log")
}

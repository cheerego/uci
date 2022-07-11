package config

import (
	"fmt"
	"path"
)

var UciDirConfigItem = NewUciConfigItem("UCI_DIR", func() string {
	return path.Join(SystemHomeDir(), fmt.Sprintf(".%s", Name))
})

func UciDir() (string, error) {
	return UciDirConfigItem.Value()
}

func UciPipelineDir(workflowId uint32, pipelineId uint32, salt string) (string, error) {
	dir, err := UciDir()
	if err != nil {
		return "", err
	}
	return path.Join(dir, fmt.Sprintf("workflow-%d-pipeline-%d-%s", workflowId, pipelineId, salt)), nil
}

func UciPipelineWorkspaceDir(workflowId uint32, pipelineId uint32, salt string) (string, error) {
	dir, err := UciPipelineDir(workflowId, pipelineId, salt)
	if err != nil {
		return "", err
	}
	return path.Join(dir, "workspace"), nil
}

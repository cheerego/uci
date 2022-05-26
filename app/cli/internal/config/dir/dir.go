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

func UciDir() string {
	return path.Join(HomeDir(), config.Name)
}

func UciTaskDir(taskName string) string {
	return path.Join(UciDir(), fmt.Sprintf("task-%s", taskName))
}

func UciTaskWorkspaceDir(taskName string) string {
	return path.Join(UciTaskDir(taskName), "workspace")
}

func UciTaskLogPath(taskName string) string {
	return path.Join(UciTaskDir(taskName), "task.log")
}

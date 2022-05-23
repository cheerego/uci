package home_dir

import (
	"github.com/cheerego/uci/app/cli/internal/config"
	"github.com/mitchellh/go-homedir"
	"path"
)

func Default() string {
	dir, _ := homedir.Dir()
	return path.Join(dir, config.Name)
}

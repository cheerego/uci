package config

import (
	"github.com/mitchellh/go-homedir"
	"path"
)

const UciEnvHomeDir = "UCI_ENV_HOME_DIR"
const UciEnvDispatchMode = "UCI_ENV_DISPATCH_MODE"

var Configs Config

type Config struct {
	HomeDir    string
	UciHomeDir string
}

func NewConfig() *Config {
	return &Config{}
}

func init() {
	config := NewConfig()
	homeDir, err := homedir.Dir()
	if err != nil {
		panic(err)
	}
	config.HomeDir = homeDir
	config.UciHomeDir = path.Join(homeDir, Name)
}

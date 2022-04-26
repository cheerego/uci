package config

import (
	"github.com/mitchellh/go-homedir"
	"path"
)

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
	config.UciHomeDir = path.Join(homeDir, "uci")
}

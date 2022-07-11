package config

import (
	"github.com/mitchellh/go-homedir"
	"sync"
)

var systemHomeDirOnce sync.Once
var systemHomeDirValue string

func SystemHomeDir() string {
	systemHomeDirOnce.Do(func() {
		dir, _ := homedir.Dir()
		systemHomeDirValue = dir
	})
	return systemHomeDirValue
}

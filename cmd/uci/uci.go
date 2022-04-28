package main

import (
	"github.com/cheerego/uci/app/cli"
	"github.com/cheerego/uci/pkg/log"
	"github.com/mitchellh/go-homedir"
	"go.uber.org/zap"
	"path"
)

func main() {
	logger, err := loggerInit()
	if err != nil {
		panic(any(err))
	}
	zap.ReplaceGlobals(logger)
	cli.Execute()
}

func loggerInit() (*zap.Logger, error) {
	dir, _ := homedir.Dir()
	return log.Console(log.DefaultLogLevel(), path.Join(dir, "uci", "uci.log"))
}

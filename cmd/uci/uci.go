package main

import (
	"github.com/cheerego/uci/pkg/log"
	"go.uber.org/zap"
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
	return log.Console(log.DefaultLogLevel())
}

package main

import (
	"github.com/cheerego/uci/app/runner"
	"github.com/labstack/gommon/log"
	"go.uber.org/zap"
)

func main() {
	log.Error("start runner err", zap.Error(runner.NewApplication().Start()))
}

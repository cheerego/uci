package main

import (
	"context"
	"github.com/cheerego/uci/app/runner"
	"github.com/labstack/gommon/log"
	"go.uber.org/zap"
)

func main() {
	//ctx, cancel := signal.NotifyContext(context.Background(), syscall.SIGINT, syscall.SIGTERM)
	ctx, cancel := context.WithCancel(context.Background())
	log.Error("start runner err", zap.Error(runner.NewApplication().Start(ctx, cancel)))
}

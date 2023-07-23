package main

import (
	"context"
	"github.com/cheerego/uci/app/twilight"
	"github.com/labstack/gommon/log"
	"go.uber.org/zap"
)

func main() {
	//ctx, cancel := signal.NotifyContext(context.Background(), syscall.SIGINT, syscall.SIGTERM)
	ctx, cancel := context.WithCancel(context.Background())
	log.Error("start twilight err", zap.Error(twilight.NewApplication().Start(ctx, cancel)))
}

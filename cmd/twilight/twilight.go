package main

import (
	"github.com/cheerego/uci/app/twilight"
	"github.com/cheerego/uci/pkg/banner"
	"github.com/cheerego/uci/pkg/log"
	"go.uber.org/zap"
)

var VERSION string
var BUILD_TIME string

func main() {
	banner.Render("twilight", VERSION, BUILD_TIME)
	//ctx, cancel := signal.NotifyContext(context.Background(), syscall.SIGINT, syscall.SIGTERM)
	log.L().Error("start twilight err", zap.Error(twilight.NewApplication().Start()))
}

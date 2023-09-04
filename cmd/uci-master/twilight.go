package main

import (
	"github.com/cheerego/uci/app/uci-master"
	"github.com/cheerego/uci/pkg/banner"
	"github.com/cheerego/uci/pkg/log"
	"go.uber.org/zap"
)

var VERSION string
var BUILD_TIME string

func main() {
	banner.Render("uci-master", VERSION, BUILD_TIME)
	//ctx, cancel := signal.NotifyContext(context.Background(), syscall.SIGINT, syscall.SIGTERM)
	err := uci_master.NewApplication().Start()
	log.Error("start uci-master err", zap.Error(err))
}

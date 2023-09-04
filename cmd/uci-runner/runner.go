package main

import (
	"github.com/cheerego/uci/app/uci-runner"
	"github.com/cheerego/uci/pkg/banner"
	"github.com/cheerego/uci/pkg/log"
	"go.uber.org/zap"
)

var VERSION string
var BUILD_TIME string

func main() {
	banner.Render("uci-master", VERSION, BUILD_TIME)
	log.Info("1231231")
	err := uci_runner.NewApplication().Start()
	log.Error("start uci-runner err", zap.Error(err))
}

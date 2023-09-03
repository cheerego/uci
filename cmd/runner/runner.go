package main

import (
	"github.com/cheerego/uci/app/runner"
	"github.com/cheerego/uci/pkg/banner"
	"github.com/cheerego/uci/pkg/log"
	"go.uber.org/zap"
)

var VERSION string
var BUILD_TIME string

func main() {
	banner.Render("twilight", VERSION, BUILD_TIME)
	log.L().Error("start runner err", zap.Error(runner.NewApplication().Start()))
}

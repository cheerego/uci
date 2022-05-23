package main

import (
	"github.com/cheerego/uci/app/cli"
	"github.com/cheerego/uci/pkg/banner"
	"github.com/cheerego/uci/pkg/log"
	"github.com/mitchellh/go-homedir"
	"go.uber.org/zap"
	"path"
)

var VERSION string
var BUILD_TIME string

func init() {
	dir, _ := homedir.Dir()
	cli, err := log.Cli(log.DefaultLogLevel(), path.Join(dir, "uci", "uci.log"))
	if err != nil {
		panic(any(err))
	}
	zap.ReplaceGlobals(cli)
}

func main() {
	banner.Render("UCI-RUNNER", VERSION, BUILD_TIME)
	cli.Execute()
}

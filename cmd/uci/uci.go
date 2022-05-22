package main

import (
	"github.com/cheerego/uci/app/cli"
	"github.com/cheerego/uci/pkg/banner"
)

var VERSION string
var BUILD_TIME string

func main() {
	banner.Render("UCI-RUNNER", VERSION, BUILD_TIME)
	cli.Execute()
}

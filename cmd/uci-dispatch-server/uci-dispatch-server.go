package main

import (
	uci_dispatch_server "github.com/cheerego/uci/app/uci-dispatch-server"
	"github.com/cheerego/uci/pkg/banner"
	"log"
)

var VERSION string
var BUILD_TIME string

func main() {
	banner.Render("UCI-MESSAGING-SERVER", VERSION, BUILD_TIME)
	app := uci_dispatch_server.NewApplication()
	err := app.Start()
	if err != nil {
		log.Fatalln("app err", err)
	}
}

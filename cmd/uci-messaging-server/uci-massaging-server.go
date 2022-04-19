package main

import (
	"github.com/cheerego/uci/app/uci-messaging-server"
	"github.com/cheerego/uci/pkg/banner"
	"github.com/cheerego/uci/pkg/signal"
)

var VERSION string
var BUILD_TIME string

func main() {
	banner.Render("UCI-MESSAGING-SERVER", VERSION, BUILD_TIME)
	app := uci_messaging_server.NewApplication()
	go app.StartHttp()

	<-signal.KillSignal()
}

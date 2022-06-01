package main

import (
	"context"
	uci_messaging_server "github.com/cheerego/uci/app/uci-messaging-server"
	"github.com/cheerego/uci/pkg/banner"
	"github.com/cheerego/uci/pkg/log/backend"
	"github.com/uptrace/opentelemetry-go-extra/otelzap"
	"go.uber.org/zap"
	"log"
)

var VERSION string
var BUILD_TIME string

func init() {
	configuration, err := backend.Configuration()
	if err != nil {
		panic(any(err))
	}
	zap.ReplaceGlobals(configuration)
	otelzap.ReplaceGlobals(otelzap.New(configuration, otelzap.WithStackTrace(true), otelzap.WithTraceIDField(true)))
}

func main() {
	banner.Render("UCI-MESSAGING-SERVER", VERSION, BUILD_TIME)
	app := uci_messaging_server.NewApplication()
	err := app.Start(context.Background())
	if err != nil {
		log.Fatalln("app err", err)
	}
}

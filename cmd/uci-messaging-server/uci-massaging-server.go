package main

import (
	"github.com/cheerego/uci/app/uci-messaging-server"
	"github.com/cheerego/uci/pkg/banner"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cheerego/uci/pkg/signal"
	"go.uber.org/zap"
)

var VERSION string
var BUILD_TIME string

func main() {
	banner.Render("UCI-MESSAGING-SERVER", VERSION, BUILD_TIME)
	app := uci_messaging_server.NewApplication()

	logger, err := loggerInit()
	if err != nil {
		panic(any(err))
	}
	zap.ReplaceGlobals(logger)

	go app.StartHttp()

	<-signal.KillSignal()
	logger.Sync()
}

func loggerInit() (*zap.Logger, error) {
	backend, err := log.Backend(log.DefaultLogLevel())
	if err != nil {
		return nil, err
	}
	return log.WrapperSentry(backend)
}

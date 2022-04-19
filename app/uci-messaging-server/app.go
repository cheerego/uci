package uci_messaging_server

import (
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/config"
	"github.com/cheerego/uci/pkg/http"
)

type Application struct {
}

func (a *Application) StartHttp() {
	echo := http.NewEcho()
	echo.Start(fmt.Sprintf(":%s", config.Configs.HttpPort))
}

func (a *Application) StartGrpc() {
}

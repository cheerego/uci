package uci_messaging_server

import (
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/config"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/web"
	"github.com/cheerego/uci/pkg/http"
)

type Application struct {
}

func NewApplication() *Application {
	return &Application{}
}

func (a *Application) StartHttp() {
	echo := http.NewEcho()

	web.Route(echo)
	echo.Start(fmt.Sprintf(":%d", config.Configs.HttpPort))
}

func (a *Application) StartGrpc() {
}

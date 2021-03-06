package internal

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/shim"
	"github.com/cheerego/uci/pkg/http/middleware/uctx"
	"github.com/labstack/echo/v4"
)

func Subscribers(c echo.Context) error {
	return uctx.FromContext(c).Data(shim.Watcher.Subscribers())
}

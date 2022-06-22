package web

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/biz/messager/internal/shim/watcher"
	"github.com/cheerego/uci/pkg/http/middleware/uctx"
	"github.com/labstack/echo/v4"
)

func Subscribers(c echo.Context) error {
	return uctx.FromContext(c).Data(watcher.Subscribers())
}

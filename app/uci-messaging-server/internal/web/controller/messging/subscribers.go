package messging

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/shim/watcher"
	"github.com/cheerego/uci/pkg/http/middleware/ectx"
	"github.com/labstack/echo/v4"
)

func Subscribers(c echo.Context) error {
	return ectx.FromContext(c).Data(watcher.Subscribers())
}

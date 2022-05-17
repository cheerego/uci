package messging

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/shim/watcher"
	"github.com/labstack/echo/v4"
)

func Publish(c echo.Context) error {
	c.Request().WithContext()
	payload := c.QueryParam("payload")
	name := c.Param("name")
	if ch, load := watcher.Load(name); load {
		ch.(chan string) <- payload
		return c.String(200, "ok")
	} else {
		return c.String(200, "no subscribe")
	}
}

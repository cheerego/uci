package web

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/web/controller/messging"
	"github.com/labstack/echo/v4"
)

func Route(r *echo.Echo) {
	r.GET("/", func(c echo.Context) error {
		return c.String(200, "hello world")
	})
	r.GET("/message/:name/subscribe", messging.Subscribe)
	r.GET("/message/:name/publish", messging.Publish)
}

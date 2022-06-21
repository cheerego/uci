package messager

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/biz/messager/internal/web"
	"github.com/labstack/echo/v4"
)

func Route(r *echo.Echo) {
	v1 := r.Group("/api/v1")
	{
		v1.GET("/message/:name/subscribe", web.Subscribe)
		v1.GET("/message/subscribers", web.Subscribers)
	}

}

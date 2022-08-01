package messager

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/web/messager/internal"
	"github.com/labstack/echo/v4"
)

func Route(r *echo.Echo) {
	v1 := r.Group("/api/v1")
	{
		v1.GET("/message/:name/subscribe", internal.Subscribe)
		v1.POST("/message/:name/unsubscribe", internal.Unsubscribe)
		v1.GET("/message/subscribers", internal.Subscribers)
		v1.POST("/message/ack/:request_id", internal.Ack)
	}

}

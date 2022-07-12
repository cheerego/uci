package internal

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/shim"
	"github.com/cheerego/uci/pkg/http/middleware/uctx"
	"github.com/labstack/echo/v4"
)

func Ack(ctx echo.Context) error {
	cc := uctx.FromContext(ctx)
	requestId := cc.Param("request_id")

	shim.Watcher.Subscribers()

}

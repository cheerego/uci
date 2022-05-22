package messging

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/pkg/http/middleware/uctx"
	"github.com/labstack/echo/v4"
)

func Publish(c echo.Context) error {
	payload := c.QueryParam("payload")
	name := c.Param("name")

	err := service.Services.MessagingService.Publish(name, payload)
	if err != nil {
		return err
	}
	return uctx.FromContext(c).Success()
}

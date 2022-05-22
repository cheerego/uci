package messging

import (
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/shim/watcher"
	"github.com/labstack/echo/v4"
	"go.uber.org/zap"
	"net/http"
)

func Subscribe(c echo.Context) error {
	name := c.Param("name")
	watch := c.QueryParam("watch")
	c.Response().Header().Set(echo.HeaderContentType, echo.MIMEApplicationJSON)
	c.Response().Flush()
	defer func() {
		watcher.Unsubscribe(name)
	}()
	if watch == "true" {
		header := c.Response().Header()
		header.Set("Transfer-Encoding", "chunked")

		c.Response().WriteHeader(http.StatusOK)
		c.Response().Flush()

		subscribe, err := service.Services.MessagingService.Subscribe(name)
		if err != nil {
			c.Error(err)
			return nil
		}
		for {
			select {

			case str, ok := <-subscribe:
				if !ok {
					zap.L().Info("chan not ok return")
					return nil
				}
				c.Logger().Info(str)
				c.Response().Write([]byte(fmt.Sprintf("%s%s", str, "\n")))
				c.Response().Flush()
			case <-c.Request().Context().Done():
				zap.L().Info("request context done")
				return nil
			case <-c.Response().Writer.(http.CloseNotifier).CloseNotify():
				zap.L().Info("CloseNotifier ")
				return nil
			}
		}
	}

	return c.NoContent(200)
}

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

	rid := c.Get(echo.HeaderXRequestID)

	if watch == "true" {

		subscribe, err := service.Services.MessagingService.Subscribe(name)
		if err != nil {
			c.Error(err)
			return nil
		}
		defer func() {
			zap.S().Infof("requestId %s client %s subscribe cancel", rid, name)
			watcher.Unsubscribe(name)
		}()
		c.Response().Flush()
		c.Response().Header().Set("Transfer-Encoding", "chunked")

		c.Response().Write([]byte("\n"))
		c.Response().Flush()

		zap.S().Infof("requestId %s client %s subscribe ing", rid, name)

		zap.S().Infof("requestId %s client %s subscribe success", rid, name)
		for {
			select {

			case str, ok := <-subscribe:
				if !ok {
					zap.S().Infof("requestId %s client %s chan not ok return", rid, name)
					return nil
				}

				c.Logger().Info(str)
				c.Response().Write([]byte(fmt.Sprintf("%s%s", str, "\n")))
				c.Response().Flush()
				zap.S().Infof("requestId %s client %s subscribe write message", rid, name)
			case <-c.Request().Context().Done():
				return c.NoContent(200)
			case <-c.Response().Writer.(http.CloseNotifier).CloseNotify():
				return c.NoContent(200)
			}
		}
	}

	return c.NoContent(200)
}

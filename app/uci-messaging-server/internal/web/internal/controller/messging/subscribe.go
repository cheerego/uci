package messging

import (
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/pkg/log"
	"github.com/labstack/echo/v4"
)

func Subscribe(c echo.Context) error {
	name := c.Param("name")
	watch := c.QueryParam("watch")

	rid := c.Get(echo.HeaderXRequestID)

	if watch == "true" {

		subscribe, err := service.Services.MessagingService.Subscribe(name)
		if err != nil {
			return err
		}
		defer func() {
			log.S().Infof("requestId %s client %s subscribe canceling", rid, name)
			service.Services.MessagingService.Unsubscribe(name)
			log.S().Infof("requestId %s client %s subscribe canceled", rid, name)
		}()

		c.Response().Header().Set("Transfer-Encoding", "chunked")
		c.Response().Write([]byte("\n"))
		c.Response().Flush()

		log.S().Infof("requestId %s client %s subscribe ing", rid, name)

		log.S().Infof("requestId %s client %s subscribe success", rid, name)
		for {
			select {

			case str, ok := <-subscribe:
				if !ok {
					log.S().Infof("requestId %s client %s chan not ok return", rid, name)
					return nil
				}

				c.Logger().Info(str)
				c.Response().Write([]byte(fmt.Sprintf("%s%s", str, "\n")))
				c.Response().Flush()
				log.S().Infof("requestId %s client %s subscribe write message", rid, name)
			case <-c.Request().Context().Done():
				log.S().Infof("requestId %s client %s request done", rid, name)
				return nil
				//case <-c.Response().Writer.(http.CloseNotifier).CloseNotify():
				//	log.S().Infof("requestId %s client %s request CloseNotifier", rid, name)
				//	return nil
			}
		}
	}

	return c.NoContent(200)
}

package internal

import (
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/facade"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/messaging"
	runner "github.com/cheerego/uci/app/uci-messaging-server/internal/model/runner"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/pkg/log"
	"github.com/labstack/echo/v4"
)

func Subscribe(c echo.Context) error {
	uuid := c.Param("name")
	watch := c.QueryParam("watch")

	rid := c.Get(echo.HeaderXRequestID)

	if watch == "true" {
		log.S().Infof("requestId %s client %s subscribe ing", rid, uuid)
		runer, err := service.Services.RunnerService.FindByUuid(c.Request().Context(), uuid)
		if err != nil {
			return err
		}
		subscribe, err := messaging.Subscribe(uuid)
		if err != nil {
			return err
		}
		defer func() {
			log.S().Infof("requestId %s runner %s subscribe canceling", rid, runer.String())
			messaging.Unsubscribe(uuid)
			log.S().Infof("requestId %s runnerr %s subscribe canceled", rid, runer.String())
		}()

		err = facade.Facades.RunnerFacade.UpdateStatus(c.Request().Context(), runer, runner.Running)
		if err != nil {
			return err
		}

		c.Response().Header().Set("Transfer-Encoding", "chunked")
		c.Response().Write([]byte("\n"))
		c.Response().Flush()

		log.S().Infof("requestId %s runner %s subscribe success", rid, runer.String())
		for {
			select {

			case str, ok := <-subscribe:
				if !ok {
					log.S().Infof("requestId %s runner %s chan not ok return", rid, runer.String())
					return nil
				}

				c.Logger().Info(str)
				c.Response().Write([]byte(fmt.Sprintf("%s%s", str, "\n")))
				c.Response().Flush()
				log.S().Infof("requestId %s runner %s subscribe write message", rid, runer.String())
			case <-c.Request().Context().Done():
				log.S().Infof("requestId %s runner %s request done", rid, runer.String())

				err = facade.Facades.RunnerFacade.UpdateStatus(c.Request().Context(), runer, runner.FakeRunning)
				if err != nil {
					return err
				}

				return nil
				//case <-c.Response().Writer.(http.CloseNotifier).CloseNotify():
				//	log.S().Infof("requestId %s client %s request CloseNotifier", rid, name)
				//	return nil
			}
		}
	}

	return c.NoContent(200)
}

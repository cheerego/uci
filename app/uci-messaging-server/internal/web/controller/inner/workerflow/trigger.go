package workerflow

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/pkg/http/middleware/uctx"
	"github.com/labstack/echo/v4"
	"net/http"
)

func Trigger(c echo.Context) error {
	cc := uctx.FromContext(c)
	workerflowId, err := cc.ParamInt32("id")
	if err != nil {
		return err
	}

	f := new(TriggerWorkflowForm)
	if err := c.Bind(f); err != nil {
		return echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}

	_, err = service.Services.WorkerflowService.FindById(cc.Request().Context(), workerflowId)
	if err != nil {
		return err
	}

	_ = service.Services.WorkerflowService.Trigger(cc.Request().Context(), workerflowId, f.Env)
	return nil
}

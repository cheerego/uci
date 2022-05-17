package workerflow

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/pkg/http/middleware/uctx"
	"github.com/labstack/echo/v4"
	"net/http"
)

func Trigger(c echo.Context) error {
	cc := uctx.FromContext(c)
	f := new(TriggerWorkflowForm)
	if err := c.Bind(f); err != nil {
		return echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}
	err := service.Services.WorkerflowService.Trigger(cc.Request().Context(), f.WorkerFlowId, f.Env)
	return cc.Success()
}

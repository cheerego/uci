package web

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/biz/workflower/internal/facade"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/pkg/http/middleware/uctx"
	"github.com/labstack/echo/v4"
	"net/http"
)

func Trigger(c echo.Context) error {
	cc := uctx.FromContext(c)
	workflowId, err := cc.ParamUint32("id")
	if err != nil {
		return err
	}

	f := new(TriggerWorkflowForm)
	if err := c.Bind(f); err != nil {
		return echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}
	workflow, err := service.Services.WorkflowService.FindById(cc.Request().Context(), workflowId)
	if err != nil {
		return err
	}

	return facade.Trigger(cc.Request().Context(), workflow, f.Envs)
}

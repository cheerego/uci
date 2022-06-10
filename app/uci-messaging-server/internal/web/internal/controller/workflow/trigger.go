package workflow

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/pkg/http/middleware/uctx"
	"github.com/cheerego/uci/pkg/log"
	"github.com/labstack/echo/v4"
	"go.uber.org/zap"
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
	log.L().Info("workflow form", zap.Any("form", f))

	workflow, err := service.Services.WorkflowService.FindById(cc.Request().Context(), workflowId)
	if err != nil {
		return err
	}

	return service.Services.WorkflowService.Trigger(cc.Request().Context(), workflow, f.Envs)
}

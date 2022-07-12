package pipeline

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/facade"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/pkg/http/middleware/uctx"
	"github.com/labstack/echo/v4"
)

func Get(c echo.Context) error {
	cc := uctx.FromContext(c)

	pipelineId, err := cc.ParamUint32("id")
	if err != nil {
		return err
	}

	p, err := service.Services.PipelineService.FindById(c.Request().Context(), pipelineId)
	if err != nil {
		return err
	}
	return cc.Data(p)
}

func Update(c echo.Context) error {
	cc := uctx.FromContext(c)

	pipelineId, err := cc.ParamUint32("id")
	if err != nil {
		return err
	}

	p, err := service.Services.PipelineService.FindById(c.Request().Context(), pipelineId)
	if err != nil {
		return err
	}
	return cc.Data(p)
}

func Stop(c echo.Context) error {
	cc := uctx.FromContext(c)
	pipelineId, err := cc.ParamUint32("id")
	if err != nil {
		return err
	}
	p, err := service.Services.PipelineService.FindById(c.Request().Context(), pipelineId)
	if err != nil {
		return err
	}

	return facade.Facades.PipelineFacade.Stop(c.Request().Context(), p)
}

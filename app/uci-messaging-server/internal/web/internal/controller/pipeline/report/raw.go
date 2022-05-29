package report

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/web/internal/controller/pipeline"
	"github.com/cheerego/uci/pkg/http/middleware/uctx"
	"github.com/labstack/echo/v4"
	"net/http"
)

func Raw(c echo.Context) error {
	f := new(pipeline.ReportRawlogForm)

	if err := c.Bind(f); err != nil {
		return echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}

	p, err := service.Services.PipelineService.FindByUuid(c.Request().Context(), f.Uuid)
	if err != nil {
		return err
	}
	_, err = service.Services.PipelineService.UpdateRawlog(c.Request().Context(), p.ID, f.Raw)
	if err != nil {
		return err
	}
	return uctx.FromContext(c).Success()
}

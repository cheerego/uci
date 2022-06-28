package report

import (
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/pkg/http/middleware/uctx"
	"github.com/labstack/echo/v4"
	"net/http"
)

func Raw(c echo.Context) error {
	f := new(ReportRawlogForm)

	if err := c.Bind(f); err != nil {
		return echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}

	p, err := service.Services.PipelineService.FindByUuid(c.Request().Context(), f.Uuid)
	if err != nil {
		return err
	}
	p.RawLog = fmt.Sprintf("%s%s", p.RawLog, f.Raw)
	_, err = service.Services.PipelineService.Update(c.Request().Context(), p)
	if err != nil {
		return err
	}
	return uctx.FromContext(c).Success()
}

package report

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/lock"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/provider"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/labstack/echo/v4"
	"net/http"
)

func BuildRunning(c echo.Context) error {
	f := new(ReportBuildRunning)
	if err := c.Bind(f); err != nil {
		return echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}
	p, err := service.Services.PipelineService.FindByUuid(c.Request().Context(), f.Uuid)
	if err != nil {
		return err
	}
	mutex := provider.Godisson().NewMutex(lock.GetPipelineLifecycleLockKey(p.ID))
	err = mutex.TryLock(-1, -1)
	if err != nil {
		return err
	}
	defer mutex.Unlock()
	_, err = service.Services.PipelineService.UpdateStatus(c.Request().Context(), p, pipeline.BuildRunning)
	if err != nil {
		return err
	}
	return nil
}

package report

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/e"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/lock"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/provider"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/labstack/echo/v4"
	"net/http"
)

func Status(c echo.Context) error {
	f := new(ReportPipelineStatus)
	if err := c.Bind(f); err != nil {
		return echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}
	p, err := service.Services.PipelineService.FindByUuid(c.Request().Context(), f.Uuid)
	if err != nil {
		return err
	}
	mutex := provider.Godisson().NewMutex(lock.GetPipelineLifecycleLockKey(p.ID))
	err = mutex.TryLock(10000, -1)
	if err != nil {
		return err
	}
	defer mutex.Unlock()

	status := pipeline.Status(c.Param("status"))
	options := make([]pipeline.StatusOption, 0)

	switch status {
	case pipeline.BuildRunning, pipeline.BuildAborted, pipeline.BuildSucceed:
	case pipeline.BuildFailed:
		options = append(options, pipeline.WithFailedCause(f.FailedCause))
	default:
		return e.ErrIllegalPipelineStatus.WithStack()
	}
	_, err = service.Services.PipelineService.UpdateStatus(c.Request().Context(), p, status, options...)
	if err != nil {
		return err
	}
	return nil
}

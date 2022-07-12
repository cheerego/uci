package pipeliner

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/web/pipeliner/internal/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/web/pipeliner/internal/report"
	"github.com/labstack/echo/v4"
)

func Route(r *echo.Echo) {
	v1 := r.Group("/api/v1")
	{
		v1.POST("/pipeline/report/log/raw", report.Raw)
		v1.POST("/pipeline/report/build-running", report.BuildRunning)
		v1.POST("/pipeline/report/build-failed", report.BuildRunning)
		v1.POST("/pipeline/report/build-aborted", report.BuildRunning)
		v1.POST("/pipeline/report/build-succeed", report.BuildRunning)
	}

	{
		v1.GET("/pipeline/:pipeline_id", pipeline.GetPipeline)
		v1.PUT("/pipeline/:pipeline_id", pipeline.UpdatePipeline)
	}

}

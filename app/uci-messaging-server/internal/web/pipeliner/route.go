package pipeliner

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/web/pipeliner/internal/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/web/pipeliner/internal/report"
	"github.com/labstack/echo/v4"
)

func Route(r *echo.Echo) {
	v1 := r.Group("/api/v1")
	{
		v1.POST("/pipeline/report/z/raw", report.Raw)
		v1.POST("/pipeline/report/status/:status", report.Status)
	}

	{
		v1.GET("/pipeline/:pipeline_id", pipeline.Get)
		v1.PUT("/pipeline/:pipeline_id", pipeline.Update)
	}

	{
		v1.POST("/inner/pipeline/:id/stop", pipeline.Stop)
	}
}

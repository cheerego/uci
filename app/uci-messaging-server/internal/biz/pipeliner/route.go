package pipeliner

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/biz/pipeliner/internal/web/report"
	"github.com/labstack/echo/v4"
)

func Route(r *echo.Echo) {
	v1 := r.Group("/api/v1")
	{
		v1.POST("/pipeline/report/log/raw", report.Raw)
	}

}

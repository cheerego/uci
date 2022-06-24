package workflower

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/web/workflower/internal"
	"github.com/labstack/echo/v4"
)

func Route(r *echo.Echo) {
	v1 := r.Group("/api/v1")
	{
		// inner
		v1.POST("/inner/workflow/:id/trigger", internal.Trigger)
	}

}

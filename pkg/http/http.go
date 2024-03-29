package http

import (
	"context"
	"github.com/labstack/echo-contrib/echoprometheus"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"github.com/labstack/gommon/log"
	uuid "github.com/satori/go.uuid"
)

func NewEcho() *echo.Echo {
	e := echo.New()
	//e.Use(middleware.LoggerWithConfig(middleware.LoggerConfig{
	//	Skipper: middleware.DefaultSkipper,
	//
	//	Format: `{"time":"${time_rfc3339_nano}","id":"${id}","remote_ip":"${remote_ip}",` +
	//		`"method":"${method}","uri":"${uri}",` +
	//		`"status":${status},"ecode":"${error}","latency":${latency},"latency_human":"${latency_human}"` +
	//		`,"bytes_in":${bytes_in},"bytes_out":${bytes_out}}` + "\n",
	//	CustomTimeFormat: "2006-01-02 15:04:05.00000",
	//}))

	e.Use(middleware.RecoverWithConfig(middleware.RecoverConfig{
		StackSize:       8 * 1024, // 1 KB
		LogLevel:        log.ERROR,
		DisableStackAll: false,
	}))
	e.Use(echoprometheus.NewMiddlewareWithConfig(echoprometheus.MiddlewareConfig{
		Skipper: func(c echo.Context) bool {
			return c.Request().URL.Path == "/metrics"
		},
	}))
	e.GET("/metrics", echoprometheus.NewHandler()) // adds route to serve gathered metrics
	e.Use(middleware.RequestIDWithConfig(middleware.RequestIDConfig{
		Generator: func() string {
			return uuid.NewV4().String()
		},
		RequestIDHandler: func(c echo.Context, s string) {
			c.Response().Header().Set(echo.HeaderXRequestID, s)
			c.Request().Header.Set(echo.HeaderXRequestID, s)
			c.Set(echo.HeaderXRequestID, s)
			r := c.Request().WithContext(context.WithValue(c.Request().Context(), echo.HeaderXRequestID, s))
			c.SetRequest(r)
		},
	}))
	return e
}

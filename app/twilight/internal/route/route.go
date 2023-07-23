package route

import (
	"github.com/labstack/echo/v4"
)

func Routes(engine *echo.Echo) {
	engine.Any("/", func(c echo.Context) error {
		return c.String(200, "hello world")
	})
	engine.Any("/api/start", func(c echo.Context) error {
		return nil
	})
	engine.Any("/web/*", func(c echo.Context) error {

		return nil
	})
}

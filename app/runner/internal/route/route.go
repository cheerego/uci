package route

import (
	"github.com/labstack/echo/v4"
)

func Routes(engine *echo.Echo) {
	engine.Any("/runner/exec", Exec)
}

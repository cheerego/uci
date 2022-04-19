package http

import (
	"github.com/labstack/echo/v4"
)
import "github.com/labstack/echo/v4/middleware"

func NewEcho() *echo.Echo {
	e := echo.New()
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())
	return e
}

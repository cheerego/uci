package types

import "github.com/labstack/echo/v4"

type StartContext struct {
	echo.Context
	StartRequest *StartRequest

	TaskName string

	Event EventType

	WithGit     bool
	GitUsername string
	GitPassword string
	GitHttpUrl  string
}

func StartContextFromContext(c echo.Context) *StartContext {
	return c.(*StartContext)
}

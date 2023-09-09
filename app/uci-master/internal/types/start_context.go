package types

import (
	"github.com/cheerego/uci/pkg/dao/model"
	"github.com/labstack/echo/v4"
)

type StartContext struct {
	echo.Context
	StartRequest *StartRequest

	TaskName string

	Event EventType

	Envs Envs

	WithGit         bool
	GitRepoUsername string
	GitRepoPassword string
	GitRepoUrl      string
	GitRepoName     string
	Runner          *model.Runner
}

func StartContextFromContext(c echo.Context) *StartContext {
	return c.(*StartContext)
}

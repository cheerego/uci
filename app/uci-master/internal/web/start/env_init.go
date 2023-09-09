package start

import (
	"github.com/cheerego/uci/app/uci-master/internal/types"
	"github.com/labstack/echo/v4"
)

func EnvInit(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {
		cc := types.StartContextFromContext(c)
		//if cc.WithGit {
		cc.Envs[types.ENV_GIT_REPO_URL] = cc.StartRequest.GitRepoUrl
		cc.Envs[types.ENV_GIT_REPO_USERNAME] = cc.StartRequest.GitRepoUsername
		cc.Envs[types.ENV_GIT_REPO_PASSWORD] = cc.StartRequest.GitRepoPassword
		cc.Envs[types.ENV_GIT_REPO_NAME] = cc.GitRepoName
		cc.Envs[types.ENV_TASK_NAME] = cc.TaskName
		//}
		return next(cc)
	}
}

package start

import (
	"github.com/labstack/echo/v4"
	"github.com/samber/lo"
	"go.uber.org/zap"
)

func GitCheck(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {
		cc := c.(*StartContext)
		if lo.IsNotEmpty(cc.StartRequest.GitHttpUrl) &&
			lo.IsNotEmpty(cc.StartRequest.GitUsername) &&
			lo.IsNotEmpty(cc.StartRequest.GitPassword) {
			cc.GitHttpUrl = cc.StartRequest.GitHttpUrl
			cc.GitUsername = cc.StartRequest.GitUsername
			cc.GitPassword = cc.StartRequest.GitPassword
			cc.WithGit = true
		}

		zap.L().Info("cc", zap.Any("cc", cc))
		return next(cc)
	}
}

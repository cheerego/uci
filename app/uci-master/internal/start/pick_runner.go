package start

import (
	"github.com/cheerego/uci/app/uci-master/internal/service"
	"github.com/cheerego/uci/app/uci-master/internal/types"
	"github.com/cheerego/uci/pkg/log"
	"github.com/labstack/echo/v4"
	"go.uber.org/zap"
)

func PickRunner(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {
		cc := types.StartContextFromContext(c)
		runner, err := service.Services.RunnerService.PickOneEnableRunner(c.Request().Context())
		if err != nil {
			log.L().Error("taskName pick uci-uci-runner err", zap.String("taskName", cc.TaskName), zap.Any("uci-uci-runner", runner), zap.Error(err))
			return err
		}
		log.L().Info("taskName pick uci-uci-runner", zap.String("taskName", cc.TaskName), zap.Any("uci-uci-runner", runner))
		cc.Runner = runner
		return next(cc)
	}
}

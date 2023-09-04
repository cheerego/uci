package start

import (
	"github.com/cheerego/uci/app/twilight/internal/service"
	"github.com/cheerego/uci/app/twilight/internal/types"
	"github.com/cheerego/uci/pkg/log"
	"github.com/labstack/echo/v4"
	"go.uber.org/zap"
)

func PickRunner(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {
		cc := types.StartContextFromContext(c)
		runner, err := service.Services.RunnerService.PickOneEnableRunner(c.Request().Context())
		if err != nil {
			log.L().Error("taskName pick runner err", zap.String("taskName", cc.TaskName), zap.Any("runner", runner), zap.Error(err))
			return err
		}
		log.L().Info("taskName pick runner", zap.String("taskName", cc.TaskName), zap.Any("runner", runner))
		cc.Runner = runner
		return next(cc)
	}
}

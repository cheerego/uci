package index

import (
	"context"
	"github.com/cheerego/uci/app/uci-dispatch-server/internal/config"
	"github.com/cheerego/uci/app/uci-dispatch-server/internal/repository"
	"github.com/labstack/echo/v4"
	"go.uber.org/zap"
)

func Index(ctx echo.Context) error {
	id, err := repository.Repositories.WorkerflowRepository.FindById(context.TODO(), 1)
	zap.L().Info("123", zap.Any("123", id), zap.Error(err))
	zap.L().Info("123123", zap.Any("config", config.Configs))
	return ctx.String(200, "Hello World, UCI DISPATCH SERVER")
}
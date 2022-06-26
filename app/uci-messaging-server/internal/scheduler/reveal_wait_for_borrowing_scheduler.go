package scheduler

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/facade"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/pkg/log"
	"go.uber.org/zap"
)

type RevealWaitForBorrowing struct {
}

func NewRevealWaitForBorrowing() *RevealWaitForBorrowing {
	return &RevealWaitForBorrowing{}
}

func (r *RevealWaitForBorrowing) Enable() (bool, string) {
	return true, facade.Facades.LockKeyFacade.GetRevealWaitForBorrowingLockKey()
}

func (r *RevealWaitForBorrowing) Exec() {
	ctx := context.TODO()
	pipelines, err := service.Services.PipelineService.FindByStatus(ctx, pipeline.WaitForBorrowing)
	if err != nil {
		log.L().Error("check wait for borrowing scheduler, find by status err", zap.Error(err))
		return
	}
	if len(pipelines) == 0 {
		return
	}

	_, err = facade.Facades.RedisQueueFacade.PublishWaitForBorrowingSet(ctx, pipelines...)
	if err != nil {
		log.L().Error("check wait for borrowing scheduler, publish wait for borrowing set", zap.Error(err), zap.Any("pipelines", pipelines))
		return
	}
}

package scheduler

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/facade"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/pkg/log"
	"go.uber.org/zap"
)

type RevealCheckBuildQueuingScheduler struct {
}

func NewRevealCheckBuildQueuingScheduler() *RevealCheckBuildQueuingScheduler {
	return &RevealCheckBuildQueuingScheduler{}
}

func (r *RevealCheckBuildQueuingScheduler) Enable() (bool, string) {
	return true, facade.Facades.LockKeyFacade.GetCheckBuildQueuingSchedulerLockKey()
}

func (r *RevealCheckBuildQueuingScheduler) Exec() {
	ctx := context.TODO()
	pipelines, err := service.Services.PipelineService.FindByStatus(ctx, pipeline.BuildQueuing)
	if err != nil {
		log.L().Error("check build queuing scheduler, find by status err", zap.Error(err))
		return
	}
	if len(pipelines) == 0 {
		return
	}

	_, err = facade.Facades.RedisQueueFacade.PublishBuildQueuingSet(ctx, pipelines...)
	if err != nil {
		log.L().Error("check build queuing scheduler, publish build queueing set", zap.Error(err), zap.Any("pipelines", pipelines))
		return
	}
}

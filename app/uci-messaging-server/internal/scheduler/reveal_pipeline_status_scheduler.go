package scheduler

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/facade"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/pkg/log"
	"go.uber.org/zap"
)

type RevealPipelineStatusScheduler struct {
}

func NewRevealPipelineStatusScheduler() *RevealPipelineStatusScheduler {
	return &RevealPipelineStatusScheduler{}
}

var _ IScheduler = (*RevealPipelineStatusScheduler)(nil)

func (r *RevealPipelineStatusScheduler) Enable(params ...interface{}) (bool, string) {
	return true, facade.Facades.LockKeyFacade.GetRevealPipelineStatusSchedulerLockKey(params[0].(pipeline.Status))
}

func (r *RevealPipelineStatusScheduler) Exec(params ...interface{}) {
	status := params[0].(pipeline.Status)
	ctx := context.TODO()
	pipelines, err := service.Services.PipelineService.FindByStatus(ctx, status)
	if err != nil {
		log.L().Error("check build queuing scheduler, find by status err", zap.Error(err), zap.String("status", string(status)))
		return
	}
	if len(pipelines) == 0 {
		return
	}

	_, err = facade.Facades.RedisQueueFacade.PublishSet(ctx, status, pipelines...)
	if err != nil {
		log.L().Error("check build queuing scheduler, publish build queueing set", zap.Error(err), zap.String("status", string(status)), zap.Any("pipelines", pipelines))
		return
	}
}

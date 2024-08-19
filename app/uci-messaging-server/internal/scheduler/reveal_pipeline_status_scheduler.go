package scheduler

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/lock"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/snapshot"
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
	status := params[0].(pipeline.Status)
	return true, lock.GetRevealPipelineStatusSchedulerLockKey(status)
}

func (r *RevealPipelineStatusScheduler) Exec(params ...interface{}) {
	status := params[0].(pipeline.Status)
	ctx := context.TODO()
	pipelines, err := service.Services.PipelineService.FindByStatus(ctx, status)
	if err != nil {
		log.Error("check build queuing scheduler, find by status err", zap.Error(err), zap.String("status", string(status)))
		return
	}
	if len(pipelines) == 0 {
		return
	}

	_, err = snapshot.PublishSet(ctx, status, pipelines...)
	if err != nil {
		log.Error("check build queuing scheduler, publish build queueing set", zap.Error(err), zap.String("status", string(status)), zap.Any("pipelines", pipelines))
		return
	}
}

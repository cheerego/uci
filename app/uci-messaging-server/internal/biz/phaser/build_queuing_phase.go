package phaser

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/locks"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/storage"
	"github.com/cheerego/uci/pkg/log"
	"go.uber.org/zap"
)

type BuildQueuingPhase struct {
}

func NewBuildQueuingPhase() *BuildQueuingPhase {
	return &BuildQueuingPhase{}
}

// Exec BuildQueuing 状态的任务会被该方法执行
// 将任务状态由 BuildQueuing -> WaitForBorrowing
func (q *BuildQueuingPhase) Exec(ctx context.Context, p *pipeline.Pipeline) error {
	key := locks.GetPipelineLifecycleLockKey(p.ID)
	rlock := storage.Godisson().NewRLock(key)
	err := rlock.TryLock(-1, -1)
	if err != nil {
		return err
	}
	defer func() {
		_, err := rlock.Unlock()
		if err != nil {
			log.L().Error("queuing phaser unlock mutex err", zap.Uint32("pipeliner", p.ID), zap.Error(err))
		}
	}()
	p, err = service.Services.PipelineService.FindById(context.TODO(), p.ID)
	if err != nil {
		return err
	}
	if p.Status != pipeline.BuildQueuing {
		return nil
	}
	_, err = service.Services.PipelineService.UpdateStatus(context.TODO(), p, pipeline.WaitForBorrowing)
	if err != nil {
		return err
	}
	log.L().Info("queuing phase pipeline status BuildQueuing -> WaitForBorrowing", zap.String("pipeliner", p.LogString()))
	return nil
}

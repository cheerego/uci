package phase

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/locks"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/storage"
	"github.com/cheerego/uci/pkg/log"
	"go.uber.org/zap"
)

type QueuingPhase struct {
}

func NewQueuingPhase() *QueuingPhase {
	return &QueuingPhase{}
}

// Exec BuildQueuing 状态的任务会被该方法执行
// 将任务状态由 BuildQueuing -> WaitForBorrowing
func (q *QueuingPhase) Exec(id uint32) error {
	key := locks.GetPipelineLifecycleLockKey(id)
	mutex := storage.Godisson().NewMutex(key)
	err := mutex.TryLock(-1, -1)
	if err != nil {
		return err
	}
	defer func() {
		_, err := mutex.Unlock()
		log.L().Error("queuing phase unlock mutex err", zap.Uint32("pipeline", id), zap.Error(err))
	}()
	p, err := service.Services.PipelineService.FindById(context.TODO(), id)
	if err != nil {
		return err
	}
	if p.Status != pipeline.BuildQueuing {
		return nil
	}
	_, err = service.Services.PipelineService.UpdateStatus(context.TODO(), p.ID, pipeline.WaitForBorrowing)
	if err != nil {
		return err
	}
	log.L().Info("queuing phase pipeline status BuildQueuing -> WaitForBorrowing", zap.String("pipeline", p.LogString()))
	return nil
}

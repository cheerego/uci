package phaser

import (
	"context"
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/biz/messager/facade"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/locks"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/storage"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cheerego/uci/protocol/letter"
	uuid "github.com/satori/go.uuid"
	"go.uber.org/zap"
	"time"
)

type WaitForDispatchingPhase struct {
}

func NewWaitForDispatchingPhase() *WaitForDispatchingPhase {
	return &WaitForDispatchingPhase{}
}

func (w WaitForDispatchingPhase) Exec(ctx context.Context, p *pipeline.Pipeline) error {
	mutex := storage.Godisson().NewMutex(locks.GetPipelineLifecycleLockKey(p.ID))
	err := mutex.TryLock(-1, -1)
	if err != nil {
		return err
	}
	defer func() {
		_, err := mutex.Unlock()
		if err != nil {
			log.L().Error("borrow phaser unlock mutex err", zap.Uint32("pipeliner", p.ID), zap.Error(err))
		}
	}()

	p, err = service.Services.PipelineService.FindById(ctx, p.ID)
	if err != nil {
		return err
	}
	if p.Status != pipeline.WaitForDispatching {
		return nil
	}

	l := &letter.Letter{
		Action:    letter.StartAction,
		RequestId: uuid.NewV4().String(),
		Payload: &letter.StartPipelinePayload{
			WorkflowId: p.WorkflowId,
			PipelineId: p.ID,
			Yaml:       p.Yaml,
			Salt:       p.Salt,
			Uuid:       p.Uuid,
			Envs:       service.Services.PipelineEnvService.EnvsToMap(p.Envs),
		},
		Timestamp: time.Now(),
	}

	log.L().Info("publishing start pipeliner letter", zap.String("pipeliner", p.LogString()), zap.Any("letter", l))
	err = facade.Publish(fmt.Sprintf("%d", p.RunnerId), l)
	if err != nil {
		log.L().Info("publishing start pipeliner letter err", zap.String("pipeliner", p.LogString()), zap.Error(err))
		return nil
	}

	_, err = service.Services.PipelineService.UpdateStatus(ctx, p, pipeline.DispatchSucceed)
	return err

}

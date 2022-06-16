package service

import (
	"context"
	"errors"
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/locks"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/runner"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/storage"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cheerego/uci/protocol/letter"
	uuid "github.com/satori/go.uuid"
	"go.uber.org/zap"
	"time"
)

type DispatchService struct {
}

func NewDispatchService() *DispatchService {
	return &DispatchService{}
}

func (d *DispatchService) TryQueuingBorrowRunner(ctx context.Context, p *pipeline.Pipeline) (*runner.Runner, error) {
	mutex := storage.Godisson().NewMutex(locks.GetPipelineLifecycleLockKey(p.ID))
	err := mutex.TryLock(-1, -1)
	if err != nil {
		return nil, err
	}
	defer mutex.Unlock()

	p, err = Services.PipelineService.FindById(ctx, p.ID)
	if err != nil {
		return nil, err
	}
	if p.Status != pipeline.BuildQueuing {
		return nil, errors.New("pipeline status had changed")
	}

	p, err = Services.PipelineService.FindById(ctx, p.ID)
	if err != nil {
		return nil, err
	}

	borrowRunner, err := Services.DispatchService.tryBorrowRunner(ctx)
	if err != nil {
		log.L().Info("pipeline borrow runner err", zap.String("pipeline", p.LogString()), zap.Error(err))
		return nil, err
	}
	log.L().Info("pipeline borrow runner success", zap.String("pipeline", p.LogString()), zap.Uint32("runner_id", borrowRunner.ID))
	// 借到机器了
	// 更新流水线相关数据
	// runnerId，status，last_dispatched_at
	p.RunnerId = borrowRunner.ID
	p.BorrowRunnerAt = time.Now()
	p.Status = pipeline.WaitingForDispatching

	_, err = Services.PipelineService.UpdateAfterBorrowedRunner(ctx, p)
	if err != nil {
		return nil, err
	}
	return borrowRunner, nil
}

func (d *DispatchService) TryDispatchStartPipelineLetter(ctx context.Context, p *pipeline.Pipeline, r *runner.Runner) error {
	l := &letter.Letter{
		Action:    letter.StartAction,
		RequestId: uuid.NewV4().String(),
		Payload: &letter.StartPipelinePayload{
			WorkflowId: p.WorkflowId,
			PipelineId: p.ID,
			Yaml:       p.Yaml,
			Salt:       p.Salt,
			Uuid:       p.Uuid,
			Envs:       Services.PipelineEnvService.EnvsToMap(p.Envs),
		},
		Timestamp: time.Now(),
	}

	log.L().Info("publishing start pipeline letter", zap.String("pipeline", p.LogString()), zap.Any("letter", l))
	err := Services.MessagingService.Publish(fmt.Sprintf("%d", r.ID), l)
	if err != nil {
		log.L().Info("publishing start pipeline letter err", zap.String("pipeline", p.LogString()), zap.Error(err))
		return nil
	}

	_, err = Services.PipelineService.UpdateStatus(ctx, p.ID, pipeline.DispatchSucceed)
	return err
}

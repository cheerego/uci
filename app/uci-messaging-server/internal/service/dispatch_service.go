package service

import (
	"context"
	"errors"
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/e"
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

// tryBorrowRunner
// CCI 归还节点会归还失败，为什么，怎么避免归还节点失败的问题? 如果无法处理，哪改如何进行兜底设计
func (d *DispatchService) tryBorrowRunner(ctx context.Context) (*runner.Runner, error) {
	idles, err := Services.RunnerService.FindIdles(ctx)
	if len(idles) == 0 {
		return nil, e.ErrBorrowRunnerNoIdle.WithStack()
	}
	firstRunner := idles[0]
	mutex := storage.Godisson().NewMutex(locks.GetRunnerBorrowLockKey(firstRunner.ID))
	err = mutex.TryLock(-1, -1)
	if err != nil {
		return nil, err
	}
	defer mutex.Unlock()
	secondRunner, err := Services.RunnerService.FindById(ctx, firstRunner.ID)
	if err != nil {
		return nil, err
	}
	if secondRunner.Status != runner.Running {
		return nil, e.ErrBorrowRunnerDoubleCheckStatus.WithStack()
	}
	return secondRunner, nil
}

func (d *DispatchService) TryQueuingBorrowRunner(ctx context.Context, p *pipeline.Pipeline) (*runner.Runner, error) {
	mutex := storage.Godisson().NewMutex(locks.GetPipelineDispatchLockKey(p.ID))
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
	p.Status = pipeline.Dispatching

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

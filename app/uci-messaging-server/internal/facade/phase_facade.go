package facade

import (
	"context"
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/e"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/locks"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/runner"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/storage"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cheerego/uci/pkg/ptr"
	"github.com/cheerego/uci/protocol/letter"
	uuid "github.com/satori/go.uuid"
	"go.uber.org/zap"
	"time"
)

type Phaser interface {
	Exec(ctx context.Context, p *pipeline.Pipeline) error
}

var Phases = map[pipeline.Status]Phaser{
	pipeline.BuildQueuing:       NewBuildQueuingPhase(),
	pipeline.WaitForBorrowing:   NewWaitForBorrowingPhase(),
	pipeline.WaitForDispatching: NewWaitForDispatchingPhase(),
}

type WaitForDispatchingPhase struct {
}

func NewWaitForDispatchingPhase() *WaitForDispatchingPhase {
	return &WaitForDispatchingPhase{}
}

func (w WaitForDispatchingPhase) Exec(ctx context.Context, p *pipeline.Pipeline) error {
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

	log.L().Info("publishing start pipeline letter", zap.String("pipeline", p.LogString()), zap.Any("letter", l))
	err = Facades.MessagingFacade.Publish(fmt.Sprintf("%d", p.RunnerId), l)
	if err != nil {
		log.L().Info("publishing start pipeline letter err", zap.String("pipeline", p.LogString()), zap.Error(err))
		return nil
	}

	_, err = service.Services.PipelineService.UpdateStatus(ctx, p, pipeline.DispatchSucceed)
	return err

}

type WaitForBorrowingPhase struct {
}

func NewWaitForBorrowingPhase() *WaitForBorrowingPhase {
	return &WaitForBorrowingPhase{}
}

func (b *WaitForBorrowingPhase) Exec(ctx context.Context, p *pipeline.Pipeline) error {
	key := locks.GetPipelineLifecycleLockKey(p.ID)
	rlock := storage.Godisson().NewRLock(key)
	err := rlock.TryLock(-1, -1)
	if err != nil {
		return err
	}
	defer func() {
		_, err := rlock.Unlock()
		if err != nil {
			log.L().Error("wait for borrowing phase unlock mutex err", zap.Uint32("pipeline", p.ID), zap.Error(err))
		}
	}()
	p, err = service.Services.PipelineService.FindById(ctx, p.ID)
	if err != nil {
		return err
	}
	if p.Status != pipeline.WaitForBorrowing {
		return nil
	}

	borrowRunner, err := b.tryBorrowRunner(ctx)
	if err != nil {
		log.L().Info("pipeline borrow runner err", zap.String("pipeline", p.LogString()), zap.Error(err))
		return err
	}

	// 借到机器了
	// 更新流水线相关数据
	// runnerId，status，last_dispatched_at
	p.RunnerId = borrowRunner.ID
	p.BorrowRunnerAt = ptr.Ptr(time.Now())
	p.Status = pipeline.WaitForDispatching

	_, err = service.Services.PipelineService.Update(ctx, p)
	if err != nil {
		return err
	}
	log.L().Info("pipeline borrow runner success, WaitForBorrowing -> WaitForDispatching", zap.String("pipeline", p.LogString()), zap.String("runner", borrowRunner.LogName()))

	return nil
}

// tryBorrowRunner
// CCI 归还节点会归还失败，为什么，怎么避免归还节点失败的问题? 如果无法处理，哪改如何进行兜底设计
func (b *WaitForBorrowingPhase) tryBorrowRunner(ctx context.Context) (*runner.Runner, error) {
	idles, err := service.Services.RunnerService.FindIdles(ctx)
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
	secondRunner, err := service.Services.RunnerService.FindById(ctx, firstRunner.ID)
	if err != nil {
		return nil, err
	}
	if secondRunner.Status != runner.Running {
		return nil, e.ErrBorrowRunnerDoubleCheckStatus.WithStack()
	}
	return secondRunner, nil
}

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

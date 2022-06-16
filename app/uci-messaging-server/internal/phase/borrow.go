package phase

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/e"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/locks"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/runner"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/storage"
	"github.com/cheerego/uci/pkg/log"
	"go.uber.org/zap"
	"time"
)

type BorrowPhase struct {
}

func (b *BorrowPhase) Exec(ctx context.Context, id uint32) error {
	mutex := storage.Godisson().NewMutex(locks.GetPipelineLifecycleLockKey(id))
	err := mutex.TryLock(-1, -1)
	if err != nil {
		return err
	}
	defer func() {
		_, err := mutex.Unlock()
		log.L().Error("borrow phase unlock mutex err", zap.Uint32("pipeline", id), zap.Error(err))
	}()

	p, err := service.Services.PipelineService.FindById(ctx, id)
	if err != nil {
		return err
	}
	if p.Status != pipeline.WaitForBorrowing {
		return nil
	}

	p, err = service.Services.PipelineService.FindById(ctx, p.ID)
	if err != nil {
		return err
	}

	borrowRunner, err := b.tryBorrowRunner(ctx)
	if err != nil {
		log.L().Info("pipeline borrow runner err", zap.String("pipeline", p.LogString()), zap.Error(err))
		return err
	}
	log.L().Info("pipeline borrow runner success", zap.String("pipeline", p.LogString()), zap.Uint32("runner_id", borrowRunner.ID))
	// 借到机器了
	// 更新流水线相关数据
	// runnerId，status，last_dispatched_at
	p.RunnerId = borrowRunner.ID
	p.BorrowRunnerAt = time.Now()
	p.Status = pipeline.BorrowRunnerSucceed

	_, err = service.Services.PipelineService.UpdateAfterBorrowedRunner(ctx, p)
	if err != nil {
		return err
	}

	return nil
}

// tryBorrowRunner
// CCI 归还节点会归还失败，为什么，怎么避免归还节点失败的问题? 如果无法处理，哪改如何进行兜底设计
func (b *BorrowPhase) tryBorrowRunner(ctx context.Context) (*runner.Runner, error) {
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

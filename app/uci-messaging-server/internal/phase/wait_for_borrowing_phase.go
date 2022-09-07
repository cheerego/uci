package phase

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/e"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/lock"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/runner"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/provider/storage"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cheerego/uci/pkg/ptr"
	"go.uber.org/zap"
	"time"
)

type WaitForBorrowingPhase struct {
}

func NewWaitForBorrowingPhase() *WaitForBorrowingPhase {
	return &WaitForBorrowingPhase{}
}

func (b *WaitForBorrowingPhase) Exec(ctx context.Context, p *pipeline.Pipeline) error {
	// 如果是第一次借机器，就设置第一次借机器的时间
	if p.FirstBorrowRunnerAt == nil {
		p.FirstBorrowRunnerAt = ptr.Ptr(time.Now())
		_, err := service.Services.PipelineService.Update(ctx, p)
		if err != nil {
			return err
		}
	}

	// 如果借机器超过了 5 分钟，则将任务状态置为借机器超时，且清理 redis 中的该流水线

	if time.Now().Sub(p.FirstBorrowRunnerAt.In(time.Local)).Minutes() > 5 {
		p.Status = pipeline.BorrowRunnerTimeouted
		_, err := service.Services.PipelineService.Update(ctx, p)
		if err != nil {
			return err
		} else {
			log.L().Info("pipeline borrow runner timeout ", zap.String("pipeline", p.LogString()))
			return nil
		}
	}

	borrowRunner, err := b.tryBorrowRunner(ctx)
	if err != nil {
		return err
	}

	// 借到机器了
	// 更新流水线相关数据
	// runnerId，status，last_dispatched_at
	p.RunnerId = borrowRunner.ID
	p.BorrowRunnerSucceedAt = ptr.Ptr(time.Now())
	p.Status = pipeline.WaitForDispatching

	_, err = service.Services.PipelineService.Update(ctx, p)
	if err != nil {
		return err
	} else {
		log.L().Info("pipeline borrow runner success, WaitForBorrowing -> WaitForDispatching", zap.String("pipeline", p.LogString()), zap.String("runner", borrowRunner.String()))
		return nil
	}

}

func (b *WaitForBorrowingPhase) Status() pipeline.Status {
	return pipeline.WaitForBorrowing
}

// tryBorrowRunner
// CCI 归还节点会归还失败，为什么，怎么避免归还节点失败的问题? 如果无法处理，哪改如何进行兜底设计
func (b *WaitForBorrowingPhase) tryBorrowRunner(ctx context.Context) (*runner.Runner, error) {
	idles, err := service.Services.RunnerService.FindIdles(ctx)
	if len(idles) == 0 {
		return nil, e.ErrBorrowRunnerNoIdle.WithStack()
	}
	firstRunner := idles[0]
	mutex := storage.Godisson().NewMutex(lock.GetRunnerBorrowLockKey(firstRunner.ID))
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

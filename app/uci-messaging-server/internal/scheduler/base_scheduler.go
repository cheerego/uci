package scheduler

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/provider"
	"github.com/cheerego/uci/pkg/log"
	"github.com/go-co-op/gocron"
	"go.uber.org/zap"
	"runtime/debug"
	"time"
)

type IScheduler interface {
	Enable(params ...interface{}) (bool, string)
	Exec(params ...interface{})
}

type BaseScheduler struct {
	IScheduler IScheduler
}

func NewBaseScheduler(IScheduler IScheduler) *BaseScheduler {
	return &BaseScheduler{IScheduler: IScheduler}
}

func (b *BaseScheduler) Do(params ...interface{}) {
	enable, lockKey := b.IScheduler.Enable(params...)
	if enable {
		mutex := provider.Godisson().NewMutex(lockKey)
		err := mutex.TryLock(-1, -1)
		if err != nil {
			return
		}
		defer mutex.Unlock()
	}
	b.IScheduler.Exec(params...)
}

type Scheduler struct {
	Scheduler *gocron.Scheduler
}

func NewScheduler() (*Scheduler, error) {
	location, err := time.LoadLocation("Asia/Shanghai")
	if err != nil {
		return nil, err
	}
	scheduler := gocron.NewScheduler(location)
	gocron.SetPanicHandler(panicHandler)
	return &Scheduler{
		Scheduler: scheduler,
	}, nil
}

func (s *Scheduler) Start() {
	s.Scheduler.Every(10).Second().Do(NewBaseScheduler(NewRevealPipelineStatusScheduler()).Do, pipeline.BuildQueuing)
	s.Scheduler.Every(10).Second().Do(NewBaseScheduler(NewSmembersPipelineStatusScheduler()).Do, pipeline.BuildQueuing)

	s.Scheduler.Every(10).Second().Do(NewBaseScheduler(NewRevealPipelineStatusScheduler()).Do, pipeline.WaitForBorrowing)
	s.Scheduler.Every(10).Second().Do(NewBaseScheduler(NewSmembersPipelineStatusScheduler()).Do, pipeline.WaitForBorrowing)

	s.Scheduler.Every(10).Second().Do(NewBaseScheduler(NewRevealPipelineStatusScheduler()).Do, pipeline.WaitForDispatching)
	s.Scheduler.Every(10).Second().Do(NewBaseScheduler(NewSmembersPipelineStatusScheduler()).Do, pipeline.WaitForDispatching)

	s.Scheduler.StartBlocking()
}

func panicHandler(jobName string, e interface{}) {
	if err, ok := e.(error); ok {
		log.L().Error("scheduler recover a err", zap.String("jobName", jobName), zap.Error(err), zap.String("stack", string(debug.Stack())))
	} else {
		log.L().Error("scheduler recover a err", zap.String("jobName", jobName), zap.String("stack", string(debug.Stack())), zap.Any("error", e))
	}
}

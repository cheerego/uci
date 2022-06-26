package scheduler

import (
	"github.com/cheerego/uci/pkg/log"
	"github.com/go-co-op/gocron"
	"go.uber.org/zap"
	"runtime/debug"
	"time"
)

type Scheduler struct {
	Scheduler *gocron.Scheduler
}

func NewScheduler() (*Scheduler, error) {
	location, err := time.LoadLocation("Asia/Shanghai")
	if err != nil {
		return nil, err
	}
	scheduler := gocron.NewScheduler(location)
	return &Scheduler{
		Scheduler: scheduler,
	}, nil
}

func (s *Scheduler) Register() {
	s.Scheduler.Every(1).Seconds().Do(func() {
		log.L().Info("cron 1s")
	})
}

func (s *Scheduler) Start() {
	s.Register()
	s.Scheduler.StartBlocking()
}

func (s *Scheduler) recovery(f func()) func() {
	return func() {
		defer func() {
			if e := recover(); e != nil {
				if err, ok := e.(error); ok {
					log.L().Error("scheduler recover a err", zap.Error(err), zap.String("stack", string(debug.Stack())))
				} else {
					log.L().Error("scheduler recover a err",, zap.String("stack", string(debug.Stack())), zap.Any("error", e))
				}
			}
			f()
		}()

	}
}

func (s *Scheduler) CheckBuildQueuingScheduler() {
}

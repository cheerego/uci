package phase

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/lock"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/provider/storage"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/scheduler"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cockroachdb/errors"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

type IPhaser interface {
	Exec(ctx context.Context, p *pipeline.Pipeline) error
	Status() pipeline.Status
}

type BasePhase struct {
	IPhaser IPhaser
}

func NewBasePhase(IPhaser IPhaser) *BasePhase {
	return &BasePhase{IPhaser: IPhaser}
}

func (b *BasePhase) Exec(ctx context.Context, id uint32) error {
	key := lock.GetPipelineLifecycleLockKey(id)
	rlock := storage.Godisson().NewRLock(key)
	err := rlock.TryLock(-1, -1)
	if err != nil {
		return err
	}
	defer func() {
		_, err := rlock.Unlock()
		if err != nil {
			log.L().Error("base phase", zap.String("status", string(b.IPhaser.Status())), zap.Uint32("pipelineId", id), zap.Error(err))
		}
	}()
	p, err := service.Services.PipelineService.FindById(ctx, id)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			_, err := scheduler.SRem(ctx, b.IPhaser.Status(), id)
			if err != nil {
				return err
			}
		}
		return err
	}
	if p.Status != b.IPhaser.Status() {
		_, err := scheduler.SRem(ctx, b.IPhaser.Status(), p.ID)
		return err
	}

	err = b.IPhaser.Exec(ctx, p)
	if err != nil {
		return err
	}

	_, err = scheduler.SRem(ctx, b.IPhaser.Status(), p.ID)

	RemainsExec(ctx, b.IPhaser.Status(), p.ID)

	return err
}

func Phases() map[pipeline.Status]*BasePhase {
	m := make(map[pipeline.Status]*BasePhase)
	for _, phase := range PhaseList() {
		m[phase.IPhaser.Status()] = phase
	}
	return m
}

func PhaseList() []*BasePhase {
	return []*BasePhase{
		NewBasePhase(NewBuildQueuingPhase()),
		NewBasePhase(NewWaitForBorrowingPhase()),
		NewBasePhase(NewWaitForDispatchingPhase()),
	}
}

func Remains(status pipeline.Status) []*BasePhase {

	remain := make([]*BasePhase, 0)
	var add bool = false
	for _, phase := range PhaseList() {
		if add {
			remain = append(remain, phase)
			continue
		}
		if phase.IPhaser.Status() == status {
			add = true
			continue
		}
	}
	return remain
}

func ListExec(ctx context.Context, id uint32) {
	for _, phase := range PhaseList() {
		err := phase.Exec(ctx, id)
		if err != nil {
			return
		}
	}
}

func RemainsExec(ctx context.Context, status pipeline.Status, id uint32) error {
	for _, phase := range Remains(status) {
		err := phase.Exec(ctx, id)
		if err != nil {
			return err
		}
	}
	return nil
}

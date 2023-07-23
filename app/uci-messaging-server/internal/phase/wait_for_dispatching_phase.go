package phase

import (
	"context"
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/shim"
	"github.com/cheerego/uci/pkg/ptr"
	"github.com/cheerego/uci/pkg/z"
	"go.uber.org/zap"
	"time"
)

type WaitForDispatchingPhase struct {
}

func (w WaitForDispatchingPhase) Status() pipeline.Status {
	return pipeline.WaitForDispatching
}

var _ IPhaser = (*WaitForDispatchingPhase)(nil)

func NewWaitForDispatchingPhase() *WaitForDispatchingPhase {
	return &WaitForDispatchingPhase{}
}

func (w WaitForDispatchingPhase) Exec(ctx context.Context, p *pipeline.Pipeline) error {

	if p.FirstDispatchedAt == nil {
		p.FirstDispatchedAt = ptr.Ptr(time.Now())
		_, err := service.Services.PipelineService.Update(ctx, p)
		if err != nil {
			return err
		}
	}

	if time.Now().Sub(p.FirstDispatchedAt.In(time.Local)).Minutes() > 5 {
		p.Status = pipeline.DispatchTimeouted
		_, err := service.Services.PipelineService.Update(ctx, p)
		if err != nil {
			return err
		} else {
			z.L().Info("pipeline dispatching timeout", zap.String("pipeline", p.String()))
			return nil
		}
	}

	p.DispatchTimes = p.DispatchTimes + 1
	p.LastDispatchedAt = ptr.Ptr(time.Now())

	l := shim.StartLetter(p)
	z.L().Info("publishing start pipeline letter", zap.String("pipeline", p.String()), zap.Any("letter", l))
	dispatchErr := shim.Watcher.PublishAck(fmt.Sprintf("%d", p.RunnerId), l)
	if dispatchErr != nil {
		z.L().Info("publishing start pipeline letter err", zap.String("pipeline", p.String()), zap.String("error", dispatchErr.Error()))
		return dispatchErr
	}
	p.DispatchSucceedAt = ptr.Ptr(time.Now())
	p.Status = pipeline.DispatchSucceed
	z.L().Info(" pipeline letter WaitForDispatching -> DispatchSucceed", zap.String("pipeline", p.String()))
	_, err := service.Services.PipelineService.Update(ctx, p)
	return err

}

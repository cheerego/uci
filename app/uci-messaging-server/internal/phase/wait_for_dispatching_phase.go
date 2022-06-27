package phase

import (
	"context"
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/messaging"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cheerego/uci/pkg/ptr"
	"github.com/cheerego/uci/protocol/letter"
	uuid "github.com/satori/go.uuid"
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
	if time.Now().Sub(*p.FirstDispatchedAt) >= 5*time.Minute {
		p.Status = pipeline.DispatchTimeouted
		_, err := service.Services.PipelineService.Update(ctx, p)
		if err != nil {
			return err
		} else {
			log.L().Info("pipeline dispatching timeout", zap.String("pipeline", p.LogString()))
			return nil
		}
	}

	p.DispatchTimes = p.DispatchTimes + 1
	p.LastDispatchedAt = ptr.Ptr(time.Now())

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
	dispatchErr := messaging.Publish(fmt.Sprintf("%d", p.RunnerId), l)
	if dispatchErr != nil {
		log.L().Info("publishing start pipeline letter err", zap.String("pipeline", p.LogString()), zap.String("error", dispatchErr.Error()))
	} else {
		p.DispatchSucceedAt = ptr.Ptr(time.Now())
		p.Status = pipeline.DispatchSucceed
		log.L().Info(" pipeline letter WaitForDispatching -> DispatchSucceed", zap.String("pipeline", p.LogString()))
	}
	_, err := service.Services.PipelineService.Update(ctx, p)
	if err != nil {
		return err
	}
	return dispatchErr

}

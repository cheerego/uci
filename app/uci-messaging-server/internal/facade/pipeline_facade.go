package facade

import (
	"context"
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/shim/watcher"
	"github.com/cheerego/uci/protocol/letter"
	uuid "github.com/satori/go.uuid"
	"time"
)

type PipelineFacade struct {
}

func NewPipelineFacade() *PipelineFacade {
	return &PipelineFacade{}
}

func (p *PipelineFacade) Stop(ctx context.Context, pl *pipeline.Pipeline) error {

	switch pl.Status {
	case pipeline.BuildRunning:
		runner, err := service.Services.RunnerService.FindById(ctx, pl.RunnerId)
		if err != nil {
			return err
		}
		err = watcher.Publish(fmt.Sprintf("%d", runner.ID), &letter.Letter{
			Action: letter.StopAction,
			Payload: letter.StopPipelinePayload{
				WorkflowId: pl.WorkflowId,
				PipelineId: pl.ID,
				Salt:       pl.Salt,
				Uuid:       pl.Uuid,
			},
			Timestamp: time.Now(),
			RequestId: uuid.NewV4().String(),
		})
		if err != nil {
			return err
		}
		_, err = service.Services.PipelineService.UpdateStatus(ctx, pl, pipeline.WaitForDispatchAborting, pipeline.WithStatusMessage("手动终止"))

		if err != nil {
			return err
		}
		return nil
	case pipeline.BuildQueuing, pipeline.WaitForBorrowing, pipeline.WaitForDispatching:
		_, err := service.Services.PipelineService.UpdateStatus(ctx, pl, pipeline.BuildAborted, pipeline.WithStatusMessage("手动终止"))
		if err != nil {
			return err
		}
		return nil
	}

	return nil
}

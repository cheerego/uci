package facade

import (
	"context"
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/shim"
)

type PipelineFacade struct {
}

func NewPipelineFacade() *PipelineFacade {
	return &PipelineFacade{}
}

func (p *PipelineFacade) Stop(ctx context.Context, pl *pipeline.Pipeline) error {

	switch pl.Status {
	case pipeline.BuildRunning, pipeline.WaitForAborting:
		runner, err := service.Services.RunnerService.FindById(ctx, pl.RunnerId)
		if err != nil {
			return err
		}
		err = shim.Watcher.PublishAck(fmt.Sprintf("%d", runner.ID), service.Services.PipelineService.StopLetter(pl))
		if err != nil {
			return err
		}
		_, err = service.Services.PipelineService.UpdateStatus(ctx, pl, pipeline.WaitForAborting, pipeline.WithStatusMessage("手动终止"))

		if err != nil {
			return err
		}
		return nil
	case pipeline.BuildQueuing, pipeline.WaitForBorrowing, pipeline.WaitForDispatching, pipeline.DispatchSucceed:
		_, err := service.Services.PipelineService.UpdateStatus(ctx, pl, pipeline.BuildAborted, pipeline.WithStatusMessage("手动终止"))
		if err != nil {
			return err
		}
		return nil
	}

	return nil
}

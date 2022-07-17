package phase

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/pkg/log"
	"go.uber.org/zap"
)

type BuildQueuingPhase struct {
}

func NewBuildQueuingPhase() *BuildQueuingPhase {
	return &BuildQueuingPhase{}
}

// Exec BuildQueuing 状态的任务会被该方法执行
// 将任务状态由 BuildQueuing -> WaitForBorrowing
func (q *BuildQueuingPhase) Exec(ctx context.Context, p *pipeline.Pipeline) error {
	_, err := service.Services.PipelineService.UpdateStatus(ctx, p, pipeline.WaitForBorrowing)
	if err != nil {
		return err
	}
	log.L().Info("queuing phase pipeline status BuildQueuing -> WaitForBorrowing", zap.String("pipeline", p.String()))
	return nil
}

func (q *BuildQueuingPhase) Status() pipeline.Status {
	return pipeline.BuildQueuing
}

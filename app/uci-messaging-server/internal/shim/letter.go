package shim

import (
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/protocol/letter"
	"time"
)

func StopLetter(pl *pipeline.Pipeline) *letter.Letter {
	return &letter.Letter{
		Action: letter.StopAction,
		Payload: letter.StopPipelinePayload{
			WorkflowId: pl.WorkflowId,
			PipelineId: pl.ID,
			Salt:       pl.Salt,
			Uuid:       pl.Uuid,
		},
		Timestamp: time.Now(),
		AckId:     fmt.Sprintf("%s-%s", letter.StopAction, pl.String()),
	}
}

func StartLetter(pl *pipeline.Pipeline) *letter.Letter {
	return &letter.Letter{
		Action: letter.StartAction,
		AckId:  fmt.Sprintf("%s-%s", letter.StartAction, pl.String()),
		Payload: &letter.StartPipelinePayload{
			WorkflowId: pl.WorkflowId,
			PipelineId: pl.ID,
			Yaml:       pl.Yaml,
			Salt:       pl.Salt,
			Uuid:       pl.Uuid,
			Envs:       service.Services.PipelineEnvService.EnvsToMap(pl.Envs),
		},
		Timestamp: time.Now(),
	}

}

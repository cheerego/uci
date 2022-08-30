package service

import (
	"context"
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/e"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service/internal/repository"
	"github.com/cheerego/uci/protocol/letter"
	"github.com/cockroachdb/errors"
	"time"
)

type PipelineService struct {
}

func NewPipelineService() *PipelineService {
	return &PipelineService{}
}

func (p *PipelineService) Create(ctx context.Context, m *pipeline.Pipeline) error {
	return repository.Repositories.PipelineRepository.Insert(ctx, m)
}

func (p *PipelineService) IncreaseDispatchTimes(ctx context.Context, id uint32) (int64, error) {
	return repository.Repositories.PipelineRepository.IncreaseDispatchTimes(ctx, id)
}

func (p *PipelineService) UpdateStatus(ctx context.Context, pl *pipeline.Pipeline, status pipeline.Status, opts ...pipeline.StatusOption) (int64, error) {
	pl.Status = status
	return repository.Repositories.PipelineRepository.UpdateStatus(ctx, pl, opts...)
}

func (p *PipelineService) UpdateEnvs(ctx context.Context, pl *pipeline.Pipeline) (int64, error) {
	return repository.Repositories.PipelineRepository.UpdateEnvs(ctx, pl)

}

func (p *PipelineService) FindById(ctx context.Context, id uint32) (*pipeline.Pipeline, error) {
	return repository.Repositories.PipelineRepository.FindById(ctx, id)
}

func (p *PipelineService) FindByUuid(ctx context.Context, uuid string) (*pipeline.Pipeline, error) {
	return repository.Repositories.PipelineRepository.FindByUuid(ctx, uuid)
}

func (p *PipelineService) UpdateRawlog(ctx context.Context, id uint32, raw string) (int64, error) {
	return repository.Repositories.PipelineRepository.UpdateRawlog(ctx, id, raw)

}

func (p *PipelineService) Update(ctx context.Context, pl *pipeline.Pipeline) (int64, error) {
	return repository.Repositories.PipelineRepository.Update(ctx, pl)
}

func (p *PipelineService) FindByStatus(ctx context.Context, s pipeline.Status) ([]*pipeline.Pipeline, error) {
	return repository.Repositories.PipelineRepository.FindByStatus(ctx, s)

}

func (p *PipelineService) StopLetter(pl *pipeline.Pipeline) *letter.Letter {
	return &letter.Letter{
		Action: letter.StopAction,
		Payload: letter.StopPipelinePayload{
			WorkflowId: pl.WorkflowId,
			PipelineId: pl.ID,
			Uuid:       pl.Uuid,
			Salt:       pl.Salt,
			TaskName:   pl.TaskName(),
		},
		Timestamp: time.Now(),
		AckId:     fmt.Sprintf("%s-%s", letter.StopAction, pl.LogString()),
	}
}

func (p *PipelineService) StartLetter(pl *pipeline.Pipeline) (*letter.Letter, error) {
	yaml, err := pl.FlowYaml()
	if err != nil {
		return nil, errors.Wrap(e.ErrIllegalPipelineYaml, err.Error())
	}

	envs := Services.PipelineEnvService.EnvsToMap(pl.Envs)

	scripts, err := yaml.Scripts(pl.TaskName(), envs)

	return &letter.Letter{
		Action: letter.StartAction,
		AckId:  fmt.Sprintf("%s-%s", letter.StartAction, pl.LogString()),
		Payload: &letter.StartPipelinePayload{
			WorkflowId: pl.WorkflowId,
			PipelineId: pl.ID,
			Scripts:    scripts,
			TaskName:   pl.TaskName(),
			Uuid:       pl.Uuid,
			Envs:       envs,
			Salt:       pl.Salt,
		},
		Timestamp: time.Now(),
	}, nil

}

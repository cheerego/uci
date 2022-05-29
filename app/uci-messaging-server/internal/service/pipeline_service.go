package service

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/repository"
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

func (p *PipelineService) UpdateStatus(ctx context.Context, id uint32, status pipeline.Status) (int64, error) {
	return repository.Repositories.PipelineRepository.UpdateStatus(ctx, id, status)
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

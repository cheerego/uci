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

// MergeEnvs 参数列表越前面优先级越低
func (p *PipelineService) MergeEnvs(e1 []*pipeline.Env, e2 ...[]*pipeline.Env) map[string]string {
	m := make(map[string]string)

	for _, env := range e1 {
		m[env.Key] = env.Value
	}

	for _, envs := range e2 {
		for _, env := range envs {
			m[env.Key] = env.Value
		}
	}
	return m
}

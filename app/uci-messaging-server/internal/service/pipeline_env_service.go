package service

import (
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
)

type PipelineEnvService struct {
}

func NewPipelineEnvService() *PipelineEnvService {
	return &PipelineEnvService{}
}

// MergeEnvs
func (p *PipelineEnvService) MergeEnvs(e1 []*pipeline.Env, e2 ...[]*pipeline.Env) []*pipeline.Env {
	envs := make([]*pipeline.Env, 0)
	envs = append(envs, e1...)

	for _, envsList := range e2 {
		envs = append(envs, envsList...)

	}
	return envs
}

func (p *PipelineEnvService) EnvsToMap(e1 []*pipeline.Env) map[string]string {
	m := make(map[string]string)

	for _, env := range e1 {
		m[env.K] = env.V
	}
	return m
}

func (p *PipelineEnvService) CollectSystemEnvs(pl *pipeline.Pipeline) []*pipeline.Env {
	return []*pipeline.Env{
		{
			K: "CI",
			V: "true",
		},
		{
			K: "PIPELINE_ID",
			V: fmt.Sprintf("%d", pl.ID),
		},
		{
			K: "WORKFLOW_ID",
			V: fmt.Sprintf("%d", pl.WorkflowId),
		},
	}
}

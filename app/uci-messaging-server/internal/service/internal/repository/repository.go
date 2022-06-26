package repository

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/provider"
)

var Repositories *Repository

type Repository struct {
	WorkflowRepository *WorkflowRepository
	PipelineRepository *PipelineRepository
	RunnerRepository   *RunnerRepository
}

func NewRepository(workflowRepository *WorkflowRepository, pipelineRepository *PipelineRepository, runnerRepository *RunnerRepository) *Repository {
	return &Repository{WorkflowRepository: workflowRepository, PipelineRepository: pipelineRepository, RunnerRepository: runnerRepository}
}

func Register() error {
	Repositories = NewRepository(
		NewWorkflowRepository(provider.MasterDB()),
		NewPipelineRepository(provider.MasterDB()),
		NewRunnerRepository(provider.MasterDB()),
	)
	return nil
}

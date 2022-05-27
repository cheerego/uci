package repository

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/storage"
)

var Repositories *Repository = NewRepository(
	NewWorkflowRepository(storage.MasterDB()),
	NewPipelineRepository(storage.MasterDB()),
)

type Repository struct {
	WorkflowRepository *WorkflowRepository
	PipelineRepository *PipelineRepository
}

func NewRepository(workflowRepository *WorkflowRepository, pipelineRepository *PipelineRepository) *Repository {
	return &Repository{WorkflowRepository: workflowRepository, PipelineRepository: pipelineRepository}
}

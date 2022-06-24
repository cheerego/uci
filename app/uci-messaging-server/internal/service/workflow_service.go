package service

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/workflow"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service/internal/repository"
)

type WorkflowService struct {
}

func NewWorkflowService() *WorkflowService {
	return &WorkflowService{}
}

func (w *WorkflowService) FindById(ctx context.Context, workerflowId uint32) (*workflow.Workflow, error) {
	return repository.Repositories.WorkflowRepository.FindById(ctx, workerflowId)
}

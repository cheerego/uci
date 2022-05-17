package service

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/workerflow"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/repository"
)

type WorkerflowService struct {
}

func NewWorkerflowService() *WorkerflowService {
	return &WorkerflowService{}
}

func (w *WorkerflowService) FindById(ctx context.Context, workerflowId int32) (*workerflow.Workerflow, error) {
	return repository.Repositories.WorkerflowRepository.FindById(ctx, workerflowId)
}

func (w *WorkerflowService) Trigger(ctx context.Context, workerFlowId int32, customEnvs []*workerflow.Env) error {
	workerflow, err := w.FindById(ctx, workerFlowId)
	if err != nil {
		return err
	}

	return nil
}

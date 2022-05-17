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

func (w *WorkerflowService) Trigger(ctx context.Context, workerFlowId int32, customEnvs []workerflow.Env) {

	workerflow, err := repository.Repositories.WorkerflowRepository.FindById(ctx, workerFlowId)

}

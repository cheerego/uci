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
	// 创建 Task
	// 收集环境变量
	// 写入数据
	// 下发指令 同步
	// 借机器

	//workerflow, err := w.FindById(ctx, workerFlowId)
	//if err != nil {
	//	return err
	//}
	// 借在线机器机器
	// 下发指令
	// 第一次下发时间

	return nil
}

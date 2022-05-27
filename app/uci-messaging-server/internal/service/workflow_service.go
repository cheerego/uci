package service

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/workflow"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/repository"
	"go.uber.org/zap"
)

type WorkflowService struct {
}

func NewWorkflowService() *WorkflowService {
	return &WorkflowService{}
}

func (w *WorkflowService) FindById(ctx context.Context, workerflowId uint32) (*workflow.Workflow, error) {
	return repository.Repositories.WorkflowRepository.FindById(ctx, workerflowId)
}

func (w *WorkflowService) Trigger(ctx context.Context, workflow *workflow.Workflow, customEnvs []*workflow.Env) error {
	// 创建 Pipeline

	p := pipeline.NewPipeline(workflow.ID, workflow.Content)

	err := Services.PipelineService.Create(ctx, p)
	if err != nil {
		return err
	}

	// 收集环境变量
	// 写入数据
	// 下发指令 同步
	// 借机器

	//workflow, err := w.FindById(ctx, workerFlowId)
	//if err != nil {
	//	return err
	//}
	// 借在线机器机器
	// 下发指令
	// 第一次下发时间

	// 借到了机器就改为下发中
	// 借不到机器就还是等待

	Services.PipelineService.IncreaseDispatchTimes(ctx, p.ID)
	err = Services.MessagingService.Publish("1", p.Yaml)
	if err != nil {
		zap.L().Error("dispatch err", zap.Uint32("workflowId", workflow.ID), zap.Uint32("pipelineId", p.ID), zap.Error(err))
		return nil
	}

	_, err = Services.PipelineService.UpdateStatus(ctx, p.ID, pipeline.DispatchSuccess)
	return err
}

package service

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/workflow"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/repository"
	"github.com/cheerego/uci/pkg/http"
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
	// 初始化 RequestId
	ctx = http.WithRequestId(ctx)
	// 创建 Pipeline
	p := pipeline.NewPipeline(workflow)

	// TODO 事务处理
	err := Services.PipelineService.Create(ctx, p)
	if err != nil {
		return err
	}
	// 收集环境变量
	systemEnv := Services.PipelineEnvService.CollectSystemEnvs(p)
	mergeEnvs := Services.PipelineEnvService.MergeEnvs(systemEnv, workflow.Envs, customEnvs)
	p.Envs = mergeEnvs

	_, err = Services.PipelineService.UpdateEnvs(ctx, p)
	if err != nil {
		return err
	}

	//runner, err := Services.DispatchService.TryQueuingBorrowRunner(ctx, p)
	//if err != nil {
	//	return err
	//}
	//Services.DispatchService.TryDispatchStartPipelineLetter(ctx, p, runner)
	return nil

	// 下发指令 同步

	//workflow, err := w.FindById(ctx, workerFlowId)
	//if err != nil {
	//	return err
	//}
	// 借在线机器机器
	// 下发指令
	// 第一次下发时间

	// 借到了机器就改为下发中
	// 借不到机器就还是等待

}

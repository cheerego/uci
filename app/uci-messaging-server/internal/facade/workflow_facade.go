package facade

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/e"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/workflow"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/phase"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
)

type WorkflowFacade struct {
}

func NewWorkflowFacade() *WorkflowFacade {
	return &WorkflowFacade{}
}

func (w *WorkflowFacade) Trigger(ctx context.Context, workflow *workflow.Workflow, customEnvs []*workflow.Env) error {
	// 创建 Pipeline
	p := pipeline.NewPipeline(workflow)

	// TODO 事务处理
	err := service.Services.PipelineService.Create(ctx, p)
	if err != nil {
		return err
	}
	// 解析 yaml 是否合法
	_, err = p.FlowYaml()
	if err != nil {
		p.Status = pipeline.ErrIllegalPipelineYaml
		p.FailedCause = err.Error()
		_, err := service.Services.PipelineService.Update(ctx, p)
		if err != nil {
			return err
		}
		return e.ErrIllegalPipelineYaml
	}

	// 收集环境变量
	systemEnv := service.Services.PipelineEnvService.CollectSystemEnvs(p)
	mergeEnvs := service.Services.PipelineEnvService.MergeEnvs(systemEnv, workflow.Envs, customEnvs)
	p.Envs = mergeEnvs

	_, err = service.Services.PipelineService.UpdateEnvs(ctx, p)
	if err != nil {
		return err
	}
	phase.Phases()[p.Status].Exec(context.TODO(), p.ID)
	return nil
}

package facade

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/lock"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/workflow"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/phase"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/provider"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/pkg/http"
	"github.com/cheerego/uci/pkg/log"
	"go.uber.org/zap"
)

type WorkflowFacade struct {
}

func NewWorkflowFacade() *WorkflowFacade {
	return &WorkflowFacade{}
}

func (w *WorkflowFacade) Trigger(ctx context.Context, workflow *workflow.Workflow, customEnvs []*workflow.Env) error {
	// 初始化 RequestId
	ctx = http.WithRequestId(ctx)
	// 创建 Pipeline
	p := pipeline.NewPipeline(workflow)

	// TODO 事务处理
	err := service.Services.PipelineService.Create(ctx, p)
	if err != nil {
		return err
	}
	// 收集环境变量
	systemEnv := service.Services.PipelineEnvService.CollectSystemEnvs(p)
	mergeEnvs := service.Services.PipelineEnvService.MergeEnvs(systemEnv, workflow.Envs, customEnvs)
	p.Envs = mergeEnvs

	_, err = service.Services.PipelineService.UpdateEnvs(ctx, p)
	if err != nil {
		return err
	}

	key := lock.GetPipelineLifecycleLockKey(p.ID)
	rlock := provider.Godisson().NewRLock(key)
	err = rlock.TryLock(-1, -1)
	if err != nil {
		return err
	}
	defer func() {
		_, err := rlock.Unlock()
		if err != nil {
			log.L().Error("queuing phase unlock mutex err", zap.Uint32("pipeline", p.ID), zap.Error(err))
		}
	}()

	err = phase.Phases()[pipeline.BuildQueuing].Exec(ctx, p.ID)
	if err != nil {
		log.L().Info("build queuing phase", zap.Error(err))
		return nil
	}

	err = phase.Phases()[pipeline.WaitForBorrowing].Exec(ctx, p.ID)
	if err != nil {
		log.L().Info("wait for borrowing phase", zap.Error(err))
		return nil
	}

	err = phase.Phases()[pipeline.WaitForDispatching].Exec(ctx, p.ID)
	if err != nil {
		log.L().Info("wait for dispatching phase", zap.Error(err))
	}
	return nil
}

package service

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/locks"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/workflow"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/repository"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/storage"
	"github.com/cheerego/uci/pkg/http"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cheerego/uci/protocol/letter"
	uuid "github.com/satori/go.uuid"
	"go.uber.org/zap"
	"time"
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
	// 借机器

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

	l := &letter.Letter{
		Action:    letter.StartAction,
		RequestId: uuid.NewV4().String(),
		Payload: &letter.StartPipelinePayload{
			WorkflowId: workflow.ID,
			PipelineId: p.ID,
			Yaml:       p.Yaml,
			Salt:       p.Salt,
			Uuid:       p.Uuid,
			Envs:       Services.PipelineEnvService.EnvsToMap(mergeEnvs),
		},
		Timestamp: time.Now(),
	}

	log.L().Info("publishing payload", zap.String("pipeline", p.LogString()), zap.Any("letter", l))
	err = Services.MessagingService.Publish("1", l)
	if err != nil {
		log.L().Info("dispatch err", zap.String("pipeline", p.LogString()), zap.Error(err))
		return nil
	}
	_, err = Services.PipelineService.UpdateStatus(ctx, p.ID, pipeline.DispatchSuccess)
	return err
}

// TryBorrowRunner
// CCI 归还节点会归还失败，为什么，怎么避免归还节点失败的问题? 如果无法处理，哪改如何进行兜底设计

func (w *WorkflowService) TryBorrowRunner(ctx context.Context, p *pipeline.Pipeline) error {
	mutex := storage.Godisson().NewMutex(locks.GetPipelineLockKey(p.ID))
	err := mutex.TryLock(-1, -1)
	if err != nil {
		return err
	}
	defer mutex.Unlock()
	idles, err := Services.RunnerService.FindIdles(ctx)
	if len(idles) == 0 {
		return nil
	}

	return nil

}

package facade

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/biz/phaser"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/workflow"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/pkg/http"
	"github.com/cheerego/uci/pkg/log"
	"go.uber.org/zap"
)

func Trigger(ctx context.Context, workflow *workflow.Workflow, customEnvs []*workflow.Env) error {
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

	err = phaser.Phases[pipeline.BuildQueuing].Exec(ctx, p)
	if err != nil {
		log.L().Info("queuing phaser", zap.Error(err))
	}

	err = phaser.Phases[pipeline.WaitForBorrowing].Exec(ctx, p)
	if err != nil {
		log.L().Info("waiting for borrowing phaser", zap.Error(err))
	}

	//runner, err := Services.DispatchService.TryQueuingBorrowRunner(ctx, p)
	//if err != nil {
	//	return err
	//}
	//Services.DispatchService.TryDispatchStartPipelineLetter(ctx, p, runner)
	return nil

	// 下发指令 同步

	//workflower, err := w.FindById(ctx, workerFlowId)
	//if err != nil {
	//	return err
	//}
	// 借在线机器机器
	// 下发指令
	// 第一次下发时间

	// 借到了机器就改为下发中
	// 借不到机器就还是等待

}

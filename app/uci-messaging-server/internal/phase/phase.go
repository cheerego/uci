package phase

// pipeline 借机器
// pipeline 获得到机器后，进行下发任务

//type Phase interface {
//	Exec(ctx context.Context, p *pipeline.Pipeline)
//}
//
//type BorrowRunnerPhase struct {
//}
//
//func (b *BorrowRunnerPhase) Exec(ctx context.Context, p *pipeline.Pipeline) error {
//	mutex := storage.Godisson().NewMutex(locks.GetPipelineDispatchLockKey(p.ID))
//	err := mutex.TryLock(-1, -1)
//	if err != nil {
//		return  err
//	}
//	defer mutex.Unlock()
//
//	p, err = service.Services.PipelineService.FindById(ctx, p.ID)
//	if err != nil {
//		return  err
//	}
//	if p.Status != pipeline.BuildQueuing {
//		return  errors.New("pipeline status had changed")
//	}
//
//	p, err = service.Services.PipelineService.FindById(ctx, p.ID)
//	if err != nil {
//		return  err
//	}
//
//	borrowRunner, err := service.Services.DispatchService.tryBorrowRunner(ctx)
//	if err != nil {
//		log.L().Info("pipeline borrow runner err", zap.String("pipeline", p.LogString()), zap.Error(err))
//		return , err
//	}
//	log.L().Info("pipeline borrow runner success", zap.String("pipeline", p.LogString()), zap.Uint32("runner_id", borrowRunner.ID))
//	// 借到机器了
//	// 更新流水线相关数据
//	// runnerId，status，last_dispatched_at
//	p.RunnerId = borrowRunner.ID
//	p.BorrowRunnerAt = time.Now()
//	p.Status = pipeline.Dispatching
//
//	_, err = Services.PipelineService.UpdateAfterBorrowedRunner(ctx, p)
//	if err != nil {
//		return nil, err
//	}
//
//}

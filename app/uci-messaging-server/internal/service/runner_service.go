package service

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/runner"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service/internal/repository"
	"github.com/cheerego/uci/pkg/log"
)

type RunnerService struct {
}

func NewRunnerService() *RunnerService {
	return &RunnerService{}
}

func (r *RunnerService) FindIdles(ctx context.Context) ([]*runner.Runner, error) {
	defaultLimit := 10
	return repository.Repositories.RunnerRepository.FindIdles(ctx, defaultLimit)
}
func (r *RunnerService) FindById(ctx context.Context, runnerId uint32) (*runner.Runner, error) {
	return repository.Repositories.RunnerRepository.FindById(ctx, runnerId)
}

func (r *RunnerService) FindByUuid(ctx context.Context, uuid string) (*runner.Runner, error) {
	return repository.Repositories.RunnerRepository.FindByUuid(ctx, uuid)
}

func (r *RunnerService) UpdateStatus(ctx context.Context, runner *runner.Runner, status runner.Status) (int64, error) {
	oldStatus := runner.Status
	runner.Status = status
	rows, err := repository.Repositories.RunnerRepository.UpdateStatus(ctx, runner)
	if err == nil {
		log.S().Infof("runner %s status %s -> %s", runner.LogName(), oldStatus, status)
	}
	return rows, err
}

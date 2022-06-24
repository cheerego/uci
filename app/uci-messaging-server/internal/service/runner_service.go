package service

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/runner"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service/internal/repository"
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

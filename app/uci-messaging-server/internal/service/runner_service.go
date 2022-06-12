package service

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/runner"
	repository "github.com/cheerego/uci/app/uci-messaging-server/internal/repository"
)

type RunnerService struct {
}

func NewRunnerService() *RunnerService {
	return &RunnerService{}
}

func (r *RunnerService) Borrow(ctx context.Context) ([]*runner.Runner, error) {
	defaultLimit := 10
	return repository.Repositories.RunnerRepository.FindIdles(ctx, defaultLimit)
}

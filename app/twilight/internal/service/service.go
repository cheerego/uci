package service

import (
	"github.com/cheerego/uci/app/twilight/internal/service/internal/repository"
)

var Services *Service

type Service struct {
	RunnerService *RunnerService
}

func NewService(runnerService *RunnerService) *Service {
	return &Service{RunnerService: runnerService}
}

func Register() error {
	repository.Register()
	Services = NewService(
		NewRunnerService(),
	)
	return nil
}

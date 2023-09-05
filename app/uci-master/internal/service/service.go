package service

import (
	"github.com/cheerego/uci/app/uci-master/internal/service/internal/repository"
)

var Services *Service

type Service struct {
	RunnerService       *RunnerService
	RunnerClientService *RunnerClientService
}

func NewService(runnerService *RunnerService, runnerClientService *RunnerClientService) *Service {
	return &Service{RunnerService: runnerService, RunnerClientService: runnerClientService}
}

func Register() error {
	repository.Register()
	Services = NewService(
		NewRunnerService(),
		NewRunnerClientService(),
	)
	return nil
}

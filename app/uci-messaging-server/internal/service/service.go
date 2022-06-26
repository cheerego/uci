package service

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service/internal/repository"
)

var Services *Service

type Service struct {
	WorkflowService    *WorkflowService
	PipelineService    *PipelineService
	PipelineEnvService *PipelineEnvService
	RunnerService      *RunnerService
}

func NewService(workflowService *WorkflowService, pipelineService *PipelineService, pipelineEnvService *PipelineEnvService, runnerService *RunnerService) *Service {
	return &Service{WorkflowService: workflowService, PipelineService: pipelineService, PipelineEnvService: pipelineEnvService, RunnerService: runnerService}
}

func Register() error {
	repository.Register()

	Services = NewService(
		NewWorkflowService(),
		NewPipelineService(),
		NewPipelineEnvService(),
		NewRunnerService(),
	)
	return nil
}

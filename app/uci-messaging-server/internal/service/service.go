package service

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

	Services = NewService(
		NewWorkflowService(),
		NewPipelineService(),
		NewPipelineEnvService(),
		NewRunnerService(),
	)
	return nil
}

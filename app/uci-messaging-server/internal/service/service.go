package service

var Services *Service

type Service struct {
	WorkflowService    *WorkflowService
	MessagingService   *MessagingService
	PipelineService    *PipelineService
	PipelineEnvService *PipelineEnvService
	RunnerService      *RunnerService
}

func NewService(workflowService *WorkflowService, messagingService *MessagingService, pipelineService *PipelineService, pipelineEnvService *PipelineEnvService, runnerService *RunnerService) *Service {
	return &Service{WorkflowService: workflowService, MessagingService: messagingService, PipelineService: pipelineService, PipelineEnvService: pipelineEnvService, RunnerService: runnerService}
}

func Register() error {

	Services = NewService(
		NewWorkflowService(),
		NewMessagingService(),
		NewPipelineService(),
		NewPipelineEnvService(),
		NewRunnerService(),
	)
	return nil
}

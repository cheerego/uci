package service

var Services *Service = NewService(
	NewWorkflowService(),
	NewMessagingService(),
	NewPipelineService(),
	NewPipelineEnvService(),
)

type Service struct {
	WorkflowService    *WorkflowService
	MessagingService   *MessagingService
	PipelineService    *PipelineService
	PipelineEnvService *PipelineEnvService
}

func NewService(workflowService *WorkflowService, messagingService *MessagingService, pipelineService *PipelineService, pipelineEnvService *PipelineEnvService) *Service {
	return &Service{WorkflowService: workflowService, MessagingService: messagingService, PipelineService: pipelineService, PipelineEnvService: pipelineEnvService}
}

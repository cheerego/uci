package service

var Services *Service = NewService(
	NewWorkflowService(),
	NewMessagingService(),
	NewPipelineService(),
)

type Service struct {
	WorkflowService  *WorkflowService
	MessagingService *MessagingService
	PipelineService  *PipelineService
}

func NewService(workflowService *WorkflowService, messagingService *MessagingService, pipelineService *PipelineService) *Service {
	return &Service{WorkflowService: workflowService, MessagingService: messagingService, PipelineService: pipelineService}
}

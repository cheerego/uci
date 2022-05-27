package service

var Services *Service = NewService(
	NewWorkerflowService(),
	NewTaskService(),
	NewMessagingService(),
)

type Service struct {
	WorkerflowService *WorkerflowService
	TaskService       *TaskService
	MessagingService  *MessagingService
}

func NewService(workerflowService *WorkerflowService, taskService *TaskService, messagingService *MessagingService) *Service {
	return &Service{WorkerflowService: workerflowService, TaskService: taskService, MessagingService: messagingService}
}

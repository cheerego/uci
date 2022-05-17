package service

var Services *Service = NewService(
	NewWorkerflowService(),
	NewTaskService(),
)

type Service struct {
	WorkerflowService *WorkerflowService
	TaskService       *TaskService
}

func NewService(workerflowService *WorkerflowService, taskService *TaskService) *Service {
	return &Service{WorkerflowService: workerflowService, TaskService: taskService}
}

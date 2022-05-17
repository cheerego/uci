package service

var Services *Service = NewService(
	NewWorkerflowService(),
)

type Service struct {
	WorkerflowService *WorkerflowService
}

func NewService(workerflowService *WorkerflowService) *Service {
	return &Service{WorkerflowService: workerflowService}
}

package repository

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/storage"
)

var Repositories *Repository

type Repository struct {
	WorkerflowRepository *PipelineRepository
}

func NewRepository(workerflow *PipelineRepository) *Repository {
	return &Repository{WorkerflowRepository: workerflow}
}
func init() {
	Repositories = NewRepository(NewWorkerflowRepository(storage.MasterDB()))
}

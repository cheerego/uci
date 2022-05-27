package repository

import (
	"github.com/cheerego/uci/app/uci-dispatch-server/internal/storage"
)

var Repositories *Repository

type Repository struct {
	WorkerflowRepository *WorkerflowRepository
}

func NewRepository(workerflow *WorkerflowRepository) *Repository {
	return &Repository{WorkerflowRepository: workerflow}
}
func init() {
	Repositories = NewRepository(NewWorkerflowRepository(storage.MasterDB()))
}

package repository

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/storage"
)

var Repositories *Repository

type Repository struct {
	PipelineRepository *PipelineRepository
}

func NewRepository(pipelineRepository *PipelineRepository) *Repository {
	return &Repository{PipelineRepository: pipelineRepository}
}
func init() {
	Repositories = NewRepository(NewPipelineRepository(storage.MasterDB()))
}

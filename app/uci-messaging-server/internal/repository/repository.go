package repository

import "github.com/cheerego/uci/app/uci-messaging-server/internal/model"

var Repositories *Repository

type Repository struct {
	PipelineRepository *PipelineRepository[model.Pipeline]
}

func NewRepository(pipelineRepository *PipelineRepository[model.Pipeline]) *Repository {
	return &Repository{PipelineRepository: pipelineRepository}
}
func init() {
	Repositories = NewRepository(NewPipelineRepository[model.Pipeline]())
}

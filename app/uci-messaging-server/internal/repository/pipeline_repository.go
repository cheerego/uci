package repository

import "github.com/cheerego/uci/app/uci-messaging-server/internal/repository/generic"

type PipelineRepository[T any] struct {
	*generic.BaseRepository[T]
}

func NewPipelineRepository[T any]() *PipelineRepository[T] {
	return &PipelineRepository[T]{
		generic.NewBaseRepository[T](),
	}
}

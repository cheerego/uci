package repository

type PipelineRepository[T any] struct {
	*BaseRepository[T]
}

func NewPipelineRepository[T any]() *PipelineRepository[T] {
	return &PipelineRepository[T]{
		NewBaseRepository[T](),
	}
}

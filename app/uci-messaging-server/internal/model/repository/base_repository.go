package repository

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/storage"
)

//https://github.com/Ompluscator/gorm-generics

type BaseRepository[T any] struct {
}

func NewBaseRepository[T any]() *BaseRepository[T] {
	return &BaseRepository[T]{}
}

func (b *BaseRepository[T]) FindById(ctx context.Context, id int32) (*T, error) {
	var m T
	err := storage.FromContext(ctx).Model(m).First(&m, id).Error
	if err != nil {
		return nil, err
	}
	return &m, err
}

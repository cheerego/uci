package generic

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/storage"
)

type BaseRepository[T any] struct {
}

func NewBaseRepository[T any]() *BaseRepository[T] {
	return &BaseRepository[T]{}
}

func (b *BaseRepository[T]) FindById(ctx context.Context, id int32) (*T, error) {
	var m T
	err := storage.FromContext(ctx).First(&m, id).Error
	if err != nil {
		return nil, err
	}
	return &m, err
}

func (b *BaseRepository[T]) FindByIdWithDeleted(ctx context.Context, id int32) (*T, error) {
	var m T
	err := storage.FromContext(ctx).Unscoped().First(&m, id).Error
	if err != nil {
		return nil, err
	}
	return &m, err
}

func (b *BaseRepository[T]) FindByIds(ctx context.Context, id ...int32) ([]*T, error) {
	m := make([]*T, 0)

	err := storage.FromContext(ctx).Find(&m, id).Error
	if err != nil {
		return nil, err
	}
	return m, err
}

func (b *BaseRepository[T]) FindByIdsWithDeleted(ctx context.Context, id ...int32) ([]*T, error) {
	m := make([]*T, 0)
	err := storage.FromContext(ctx).Unscoped().Find(&m, id).Error
	if err != nil {
		return nil, err
	}
	return m, err
}

func (b *BaseRepository[T]) Insert(ctx context.Context, m *T) error {
	err := storage.FromContext(ctx).Create(m).Error
	return err
}

func (b *BaseRepository[T]) BatchInsert(ctx context.Context, m []*T) (int64, error) {
	tx := storage.FromContext(ctx).Create(m)
	return tx.RowsAffected, tx.Error
}

func (b *BaseRepository[T]) DeleteById(ctx context.Context, id int32) (int64, error) {
	var m T
	tx := storage.FromContext(ctx).Delete(&m, id)
	return tx.RowsAffected, tx.Error
}

func (b *BaseRepository[T]) DeleteByIds(ctx context.Context, ids int32) (int64, error) {
	var m T
	tx := storage.FromContext(ctx).Delete(&m, ids)
	return tx.RowsAffected, tx.Error
}

func (b *BaseRepository[T]) ForceDeleteById(ctx context.Context, id int32) (int64, error) {
	var m T
	tx := storage.FromContext(ctx).Unscoped().Delete(&m, id)
	return tx.RowsAffected, tx.Error
}

func (b *BaseRepository[T]) ForceDeleteByIds(ctx context.Context, ids ...int32) (int64, error) {
	var m T
	tx := storage.FromContext(ctx).Unscoped().Delete(&m, ids)
	return tx.RowsAffected, tx.Error
}

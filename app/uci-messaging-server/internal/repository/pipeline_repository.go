package repository

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/pkg/orm"
	"gorm.io/gorm"
	"time"
)

type PipelineRepository struct {
	orm.BaseRepository[pipeline.Pipeline]
	db *gorm.DB
}

func NewPipelineRepository(db *gorm.DB) *PipelineRepository {
	return &PipelineRepository{
		db:             db,
		BaseRepository: orm.NewBaseRepository[pipeline.Pipeline](db),
	}
}

func (p *PipelineRepository) IncreaseDispatchTimes(ctx context.Context, id uint32) (int64, error) {
	var m pipeline.Pipeline
	tx := orm.FromContext(ctx, p.db).Model(&m).Where(id).Updates(map[string]interface{}{
		"dispatch_times":     gorm.Expr("dispatch_times + ?", 1),
		"last_dispatch_time": time.Now(),
	})
	return tx.RowsAffected, tx.Error

}

func (p *PipelineRepository) UpdateStatus(ctx context.Context, id uint32, status pipeline.Status) (int64, error) {
	var m pipeline.Pipeline

	tx := orm.FromContext(ctx, p.db).Model(&m).Where(id).Select("status").Updates(map[string]interface{}{
		"status": status,
	})
	return tx.RowsAffected, tx.Error
}

func (p *PipelineRepository) FindByUuid(ctx context.Context, uuid string) (*pipeline.Pipeline, error) {
	var m pipeline.Pipeline
	tx := orm.FromContext(ctx, p.db).Model(&m).Where("uuid = ?", uuid).First(&m)
	if tx.Error != nil {
		return nil, tx.Error
	}
	return &m, nil
}

func (p *PipelineRepository) UpdateRawlog(ctx context.Context, id uint32, raw string) (int64, error) {
	var m pipeline.Pipeline
	tx := orm.FromContext(ctx, p.db).Model(&m).Where(id).Updates(map[string]interface{}{
		"raw_log": raw,
	})
	return tx.RowsAffected, tx.Error
}

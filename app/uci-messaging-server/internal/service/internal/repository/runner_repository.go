package repository

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/runner"
	"github.com/cheerego/uci/pkg/orm"
	"gorm.io/gorm"
)

type RunnerRepository struct {
	orm.BaseRepository[runner.Runner]
	db *gorm.DB
}

func NewRunnerRepository(db *gorm.DB) *RunnerRepository {
	//
	return &RunnerRepository{
		BaseRepository: orm.NewBaseRepository[runner.Runner](db),
		db:             db,
	}
}

func (r *RunnerRepository) FindIdles(ctx context.Context, limit int) ([]*runner.Runner, error) {
	m := make([]*runner.Runner, 0)
	tx := orm.FromContext(ctx, r.db).Where("status = ?", runner.Running).Order("last_dispatched_at asc").Limit(limit).Find(&m)
	return m, tx.Error

}

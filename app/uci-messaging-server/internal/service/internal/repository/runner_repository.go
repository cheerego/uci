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

func (r *RunnerRepository) UpdateStatus(ctx context.Context, runner *runner.Runner) (int64, error) {
	tx := orm.FromContext(ctx, r.db).Select("Status").Updates(runner)
	return tx.RowsAffected, tx.Error
}

func (r *RunnerRepository) FindByUuid(ctx context.Context, uuid string) (*runner.Runner, error) {
	var m runner.Runner
	err := orm.FromContext(ctx, r.db).Where("code = ?", uuid).First(&m, 1).Error
	if err != nil {
		return nil, err
	}
	return &m, nil
}

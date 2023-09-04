package dao

import (
	"context"
	"github.com/cheerego/uci/pkg/dao/model"
	"github.com/cheerego/uci/pkg/orm"
	"gorm.io/gorm"
)

type RunnerRepository struct {
	orm.BaseRepository[model.Runner]
	DB *gorm.DB
}

func NewRunnerRepository(DB *gorm.DB) *RunnerRepository {
	return &RunnerRepository{DB: DB}
}

func (r *RunnerRepository) FindRunnersByEnable(ctx context.Context, enable bool) ([]*model.Runner, error) {
	m := make([]*model.Runner, 0)
	err := orm.FromContext(ctx, r.DB).Where("enable = ?", enable).Find(&m).Error
	return m, err
}

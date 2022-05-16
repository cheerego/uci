package repository

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/workerflow"
	"github.com/cheerego/uci/pkg/orm"
	"gorm.io/gorm"
)

type PipelineRepository struct {
	orm.BaseRepository[workerflow.Workerflow]
	db *gorm.DB
}

func NewWorkerflowRepository(db *gorm.DB) *PipelineRepository {
	//
	return &PipelineRepository{
		BaseRepository: orm.NewBaseRepository[workerflow.Workerflow](db),
		db:             db,
	}
}

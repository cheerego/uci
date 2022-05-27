package repository

import (
	"github.com/cheerego/uci/app/uci-dispatch-server/internal/model/workerflow"
	"github.com/cheerego/uci/pkg/orm"
	"gorm.io/gorm"
)

type WorkerflowRepository struct {
	orm.BaseRepository[workerflow.Workerflow]
	db *gorm.DB
}

func NewWorkerflowRepository(db *gorm.DB) *WorkerflowRepository {
	//
	return &WorkerflowRepository{
		BaseRepository: orm.NewBaseRepository[workerflow.Workerflow](db),
		db:             db,
	}
}

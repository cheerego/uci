package repository

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/workerflow"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/repository/generic"
	"github.com/cheerego/uci/pkg/db"
	"gorm.io/gorm"
)

type PipelineRepository struct {
	generic.BaseRepository[workerflow.Workerflow]
	db *gorm.DB
}

func NewWorkerflowRepository(db *gorm.DB) *PipelineRepository {
	//
	return &PipelineRepository{
		BaseRepository: generic.NewBaseRepository[workerflow.Workerflow](db),
		db:             db,
	}
}

func (p *PipelineRepository[T]) A(ctx context.Context) {
	db.FromContext(ctx, p.db)
}

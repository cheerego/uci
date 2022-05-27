package repository

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/workflow"
	"github.com/cheerego/uci/pkg/orm"
	"gorm.io/gorm"
)

type WorkflowRepository struct {
	orm.BaseRepository[workflow.Workflow]
	db *gorm.DB
}

func NewWorkflowRepository(db *gorm.DB) *WorkflowRepository {
	//
	return &WorkflowRepository{
		BaseRepository: orm.NewBaseRepository[workflow.Workflow](db),
		db:             db,
	}
}

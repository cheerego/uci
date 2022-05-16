package model

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline_status"
	"gorm.io/gorm"
)

type Workerflow struct {
	gorm.Model
	RepoId uint32
	Status pipeline_status.Status
	Yaml   string

	Yal
}

func NewPipeline(name string, status pipeline_status.Status, yaml string) *Workerflow {
	return &Workerflow{Name: name, Status: status, Yaml: yaml}
}

func (p *Workerflow) TableName() string {
	return "pipelines"
}

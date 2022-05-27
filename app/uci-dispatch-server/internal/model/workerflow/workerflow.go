package workerflow

import (
	"gorm.io/gorm"
)

type Workerflow struct {
	gorm.Model
	Name   string
	RepoId uint32
	Yaml   string
	Enable bool
	//Envs   []*Env
}

func NewWorkerflow(name string, repoId uint32, yaml string, enable bool) *Workerflow {
	return &Workerflow{Name: name, RepoId: repoId, Yaml: yaml, Enable: enable}
}

func (p *Workerflow) TableName() string {
	return "workerflows"
}

package workflow

import (
	"github.com/cheerego/uci/pkg/orm"
)

type Workflow struct {
	orm.Model
	Name string
	//RepoId uint32
	Yaml string
	//Enable bool
	Envs Envs
}

//func NewWorkflow(name string, repoId uint32, yaml string, enable bool) *Workflow {
//	return &Workflow{Name: name, RepoId: repoId, Scripts: yaml, Enable: enable}
//}

func (p *Workflow) TableName() string {
	return "workflows"
}

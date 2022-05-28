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
	//ParamEnv map[string]string
}

func (p Workflow) PK() uint32 {
	return p.ID
}

//func NewWorkflow(name string, repoId uint32, yaml string, enable bool) *Workflow {
//	return &Workflow{Name: name, RepoId: repoId, Yaml: yaml, Enable: enable}
//}

func (p *Workflow) TableName() string {
	return "workflows"
}

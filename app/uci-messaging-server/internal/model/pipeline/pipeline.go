package pipeline

import (
	"github.com/cheerego/uci/pkg/orm"
	uuid "github.com/satori/go.uuid"
	"time"
)

type Pipeline struct {
	orm.Model
	WorkflowId uint32
	Yaml       string
	Salt       string

	LastDispatchTime *time.Time
	Status           Status
	StatusMessage    string
	RawLog           string
	Uuid             string
	DispatchTimes    uint32

	//CurrentStep      string
}

func (p Pipeline) PK() uint32 {
	return p.ID
}

func NewPipeline(workflowId uint32, yaml string) *Pipeline {
	uid := uuid.NewV4().String()
	salt := uid[0:8]
	return &Pipeline{
		Model:            orm.Model{},
		WorkflowId:       workflowId,
		Yaml:             yaml,
		Salt:             salt,
		LastDispatchTime: nil,
		Status:           Queuing,
		RawLog:           "",
		Uuid:             uid,
		DispatchTimes:    0,
	}
}

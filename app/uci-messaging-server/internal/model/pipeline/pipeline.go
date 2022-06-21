package pipeline

import (
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/workflow"
	"github.com/cheerego/uci/pkg/orm"
	uuid "github.com/satori/go.uuid"
	"time"
)

type Pipeline struct {
	orm.Model
	WorkflowId uint32
	Yaml       string
	Salt       string

	LastDispatchedAt  time.Time
	DispatchSucceedAt time.Time
	BorrowRunnerAt    time.Time
	Envs              Envs
	Status            Status
	StatusMessage     string
	RawLog            string
	Uuid              string
	DispatchTimes     uint32
	RunnerId          uint32

	//CurrentStep      string
}

func NewPipeline(workflow *workflow.Workflow) *Pipeline {
	uid := uuid.NewV4().String()
	salt := uid[0:8]
	return &Pipeline{
		Model:         orm.Model{},
		WorkflowId:    workflow.ID,
		Yaml:          workflow.Yaml,
		Salt:          salt,
		Envs:          make([]*Env, 0),
		Status:        BuildQueuing,
		StatusMessage: "",
		RawLog:        "",
		Uuid:          uid,
		DispatchTimes: 0,
		RunnerId:      0,
	}
}
func (p Pipeline) LogString() string {
	return fmt.Sprintf("workflower-%d-uuid-%s-pipeliner-%d-%s", p.WorkflowId, p.Uuid, p.ID, p.Salt)
}

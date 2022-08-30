package pipeline

import (
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/workflow"
	"github.com/cheerego/uci/pkg/orm"
	"github.com/cheerego/uci/pkg/ptr"
	"github.com/cheerego/uci/protocol/flow"
	uuid "github.com/satori/go.uuid"
	"gopkg.in/yaml.v2"
	"time"
)

type StatusOption func(pipeline *Pipeline) string

func WithFailedCause(failedCause string) StatusOption {
	return func(pipeline *Pipeline) string {
		pipeline.FailedCause = failedCause
		return "FailedCause"
	}
}
func WithStartedAt(at time.Time) StatusOption {
	return func(pipeline *Pipeline) string {
		pipeline.StartedAt = ptr.Ptr(at)
		return "StartedAt"
	}
}

func WithCloseAt(at time.Time) StatusOption {
	return func(pipeline *Pipeline) string {
		pipeline.ClosedAt = ptr.Ptr(at)
		return "ClosedAt"
	}
}

func WithStatusMessage(msg string) StatusOption {
	return func(pipeline *Pipeline) string {
		pipeline.StatusMessage = msg
		return "StatusMessage"
	}
}

type Pipeline struct {
	orm.Model
	WorkflowId uint32
	Number     uint32
	Uuid       string
	Salt       string
	Yaml       string

	FirstDispatchedAt *time.Time
	LastDispatchedAt  *time.Time
	DispatchSucceedAt *time.Time
	DispatchTimes     uint32

	RunnerId              uint32
	FirstBorrowRunnerAt   *time.Time
	BorrowRunnerSucceedAt *time.Time
	ReleaseRunnerAt       *time.Time

	StartedAt *time.Time
	ClosedAt  *time.Time
	Duration  uint32

	TriggeredCause string
	FailedCause    string

	Envs                Envs
	Status              Status
	LastStatusChangedAt *time.Time
	StatusMessage       string
	RawLog              string

	//CurrentStep      string
}

func NewPipeline(workflow *workflow.Workflow) *Pipeline {
	uid := uuid.NewV4().String()
	salt := uid[0:8]
	return &Pipeline{
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

func (p *Pipeline) TaskName() string {
	return fmt.Sprintf("workflow-%d-pipeline-%d-%s", p.WorkflowId, p.ID, p.Salt)
}

func (p *Pipeline) LogString() string {
	return fmt.Sprintf("workflow-%d-pipeline-%d-%s-runner-%d", p.WorkflowId, p.ID, p.Salt, p.RunnerId)
}

func (p *Pipeline) FlowYaml() (*flow.FlowYaml, error) {
	var fy flow.FlowYaml

	err := yaml.Unmarshal([]byte(p.Yaml), &fy)
	if err != nil {
		return nil, err
	}

	return &fy, nil
}

package letter

import (
	"encoding/json"
	"github.com/cheerego/uci/protocol/flow"
	"time"
)

type Letter struct {
	Action    Action      `json:"action"`
	Payload   interface{} `json:"payload"`
	Timestamp time.Time   `json:"timestamp"`
	AckId     string      `json:"ackId"`
}

type StartPipelinePayload struct {
	WorkflowId uint32               `json:"workflowId"`
	PipelineId uint32               `json:"pipelineId"`
	Scripts    *flow.WorkflowScript `json:"scripts"`
	Uuid       string               `json:"uuid"`
	Envs       map[string]string    `json:"envs"`
	TaskName   string               `json:"taskName"`
	Salt       string               `json:"salt"`
}

type StopPipelinePayload struct {
	WorkflowId uint32 `json:"workflowId"`
	PipelineId uint32 `json:"pipelineId"`
	Salt       string `json:"salt"`
	Uuid       string `json:"uuid"`
	TaskName   string `json:"taskName"`
}

//func (s *StopPipelinePayload) String() string {
//	return fmt.Sprintf("workflow-%d-uuid-%s-pipeline-%d-%s", s.WorkflowId, s.Uuid, s.PipelineId, s.Salt)
//}

type Action string

const StartAction = "start_pipeline"
const StopAction = "stop_pipeline"

func (l *Letter) StartPipelinePayload() (*StartPipelinePayload, error) {
	marshal, err := json.Marshal(l.Payload)
	if err != nil {
		return nil, err
	}

	var p StartPipelinePayload

	err = json.Unmarshal(marshal, &p)
	if err != nil {
		return nil, err
	}
	return &p, nil
}

func (l *Letter) StopPipelinePayload() (*StopPipelinePayload, error) {
	marshal, err := json.Marshal(l.Payload)
	if err != nil {
		return nil, err
	}

	var p StopPipelinePayload

	err = json.Unmarshal(marshal, &p)
	if err != nil {
		return nil, err
	}
	return &p, nil

}

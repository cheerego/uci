package letter

import (
	"encoding/json"
	"fmt"
	"time"
)

type Letter struct {
	Action    Action      `json:"action"`
	Payload   interface{} `json:"payload"`
	Timestamp time.Time   `json:"timestamp"`
	AckId     string      `json:"ackId"`
}

type StartPipelinePayload struct {
	WorkflowId int64             `json:"workflowId"`
	PipelineId int64             `json:"pipelineId"`
	Yaml       string            `json:"yaml"`
	Salt       string            `json:"salt"`
	Uuid       string            `json:"uuid"`
	Envs       map[string]string `json:"envs"`
}

func (s *StartPipelinePayload) String() string {
	return fmt.Sprintf("workflow-%d-uuid-%s-pipeline-%d-%s", s.WorkflowId, s.Uuid, s.PipelineId, s.Salt)
}

type StopPipelinePayload struct {
	WorkflowId int64  `json:"workflowId"`
	PipelineId int64  `json:"pipelineId"`
	Salt       string `json:"salt"`
	Uuid       string `json:"uuid"`
}

func (s *StopPipelinePayload) String() string {
	return fmt.Sprintf("workflow-%d-uuid-%s-pipeline-%d-%s", s.WorkflowId, s.Uuid, s.PipelineId, s.Salt)
}

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

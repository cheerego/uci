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
	RequestId string      `json:"requestId"`
}

type StartPipelinePayload struct {
	WorkflowId uint32            `json:"workflowId"`
	PipelineId uint32            `json:"pipelineId"`
	Yaml       string            `json:"yaml"`
	Salt       string            `json:"salt"`
	Uuid       string            `json:"uuid"`
	Envs       map[string]string `json:"envs"`
}

func (s *StartPipelinePayload) LogName() string {
	return fmt.Sprintf("workflower-%d-uuid-%s-pipeliner-%d-%s", s.WorkflowId, s.Uuid, s.PipelineId, s.Salt)
}

type Action string

const StartAction = "start"
const StopAction = "stop"

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
	return &p, err
}
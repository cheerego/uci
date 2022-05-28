package letter

import (
	"encoding/json"
	"github.com/cheerego/uci/protocol/letter/payload"
	"time"
)

type Letter struct {
	Action    Action      `json:"action"`
	Payload   interface{} `json:"payload"`
	Timestamp time.Time   `json:"timestamp"`
}

type Action string

const StartAction = "start"
const StopAction = "stop"

func (l *Letter) StartPipelinePayload() (*payload.StartPipelinePayload, error) {
	marshal, err := json.Marshal(l.Payload)
	if err != nil {
		return nil, err
	}

	var p payload.StartPipelinePayload

	err = json.Unmarshal(marshal, &p)
	if err != nil {
		return nil, err
	}
	return &p, err
}

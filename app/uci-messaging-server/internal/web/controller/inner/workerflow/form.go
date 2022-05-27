package workerflow

import "github.com/cheerego/uci/app/uci-messaging-server/internal/model/workerflow"

type (
	//TriggerWorkflowForm
	// 出发构建
	TriggerWorkflowForm struct {
		Revision string            `json:"revision,omitempty"`
		Env      []*workerflow.Env `json:"env,omitempty"`
	}
)

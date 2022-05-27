package workerflow

import "github.com/cheerego/uci/app/uci-messaging-server/internal/model/workflow"

type (
	//TriggerWorkflowForm
	// 出发构建
	TriggerWorkflowForm struct {
		Revision string          `json:"revision,omitempty"`
		Env      []*workflow.Env `json:"env,omitempty"`
	}
)

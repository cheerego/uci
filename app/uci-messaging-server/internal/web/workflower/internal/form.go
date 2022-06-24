package internal

import "github.com/cheerego/uci/app/uci-messaging-server/internal/model/workflow"

type (
	//TriggerWorkflowForm
	// 出发构建
	TriggerWorkflowForm struct {
		Revision string          `json:"revision,omitempty"`
		Envs     []*workflow.Env `json:"envs,omitempty"`
	}
)

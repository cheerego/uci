package workerflow

import "github.com/cheerego/uci/app/uci-messaging-server/internal/model/workerflow"

type (
	//TriggerWorkflowForm
	// 出发构建
	TriggerWorkflowForm struct {
		WorkerFlowId int32             `json:"worker_flow_id,omitempty" validate:"required"`
		Revision     string            `json:"revision,omitempty"`
		Env          []*workerflow.Env `json:"env,omitempty"`
	}
)

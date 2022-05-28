package executor

import (
	"encoding/json"
	"github.com/cheerego/uci/protocol/letter"
	"github.com/cheerego/uci/protocol/letter/payload"
	"go.uber.org/zap"
)

var E = NewExecutor()

type IExecutor interface {
	Start(payload *payload.StartPipelinePayload)
	PrepareWorkspace(payload *payload.StartPipelinePayload) error
}

type Executor struct {
	HostExecutor IExecutor
}

func NewExecutor() *Executor {
	return &Executor{
		NewHostExecutor(),
	}
}

func (o *Executor) Exec(dispatchMessage string) {
	var l letter.Letter
	err := json.Unmarshal([]byte(dispatchMessage), &l)
	if err != nil {
		zap.L().Error("json.Unmarshal dispatchMessage err", zap.Error(err), zap.String("dispatchMessage", dispatchMessage))
		return
	}

	switch l.Action {
	case letter.StartAction:
		p, err := l.StartPipelinePayload()
		if err != nil {
			zap.L().Error("parse start pipeline payload err", zap.Error(err))
			return
		}
		go o.HostExecutor.Start(p)
	case letter.StopAction:
	default:
		zap.L().Error("无效的 action 类型", zap.String("dispatchMessage", dispatchMessage), zap.String("action", string(l.Action)))
	}

}

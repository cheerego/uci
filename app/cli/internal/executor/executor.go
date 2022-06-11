package executor

import (
	"context"
	"encoding/json"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cheerego/uci/protocol/letter"
	"go.uber.org/zap"
)

var E = NewExecutor()

type IExecutor interface {
	Start(ctx context.Context, payload *letter.StartPipelinePayload) error
	//PrepareWorkspace(payload *payload.StartPipelinePayload) error
}

type Executor struct {
	HostExecutor IExecutor
}

func NewExecutor() *Executor {
	return &Executor{
		NewHostExecutor(),
	}
}

func (o *Executor) Exec(ctx context.Context, dispatchMessage string) {
	var l letter.Letter
	err := json.Unmarshal([]byte(dispatchMessage), &l)
	if err != nil {
		log.L().Error("json.Unmarshal dispatchMessage err", zap.Error(err), zap.String("dispatchMessage", dispatchMessage))
		return
	}

	switch l.Action {
	case letter.StartAction:
		p, err := l.StartPipelinePayload()
		if err != nil {
			log.L().Error("parse start pipeline payload err", zap.Error(err))
			return
		}
		go func() {
			err := o.HostExecutor.Start(ctx, p)
			if err != nil {
				log.L().Error("after start", zap.Error(err))
				return
			}
		}()

	case letter.StopAction:
	default:
		log.L().Error("无效的 action 类型", zap.String("dispatchMessage", dispatchMessage), zap.String("action", string(l.Action)))
	}

}

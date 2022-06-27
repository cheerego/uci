package executor

import (
	"bytes"
	"context"
	"encoding/json"
	"github.com/cheerego/uci/app/cli/internal/collector"
	"github.com/cheerego/uci/app/cli/internal/requests"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cheerego/uci/protocol/letter"
	"go.uber.org/zap"
	"time"
)

var E = NewExecutor()

type IExecutor interface {
	Start(ctx context.Context, payload *letter.StartPipelinePayload, pipe *bytes.Buffer) error
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

func (o *Executor) Exec(ctx context.Context, letterString string) {
	var l letter.Letter
	err := json.Unmarshal([]byte(letterString), &l)
	if err != nil {
		log.L().Error("json.Unmarshal letterString err", zap.Error(err), zap.String("letterString", letterString))
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
			time.Sleep(2 * time.Second)
			err := requests.ReportPipelineStatus(ctx, p.Uuid, "BUILD_RUNNING", "")
			if err != nil {
				log.L().Error("report pipeline status BUILD_RUNNING", zap.String("pipeline", p.LogName()))
				return
			}
			pipe := bytes.NewBufferString("")
			collector.NewCollector().CollectorRawlog(ctx, p, pipe)
			err = o.HostExecutor.Start(ctx, p, pipe)
			if err != nil {
				log.L().Error("after start", zap.String("pipeline", p.LogName()), zap.Error(err))
				requests.ReportPipelineStatus(ctx, p.Uuid, "BUILD_FAILED", err.Error())
				return
			} else {
				requests.ReportPipelineStatus(ctx, p.Uuid, "BUILD_SUCCEED", "")
				return
			}

		}()

	case letter.StopAction:
	default:
		log.L().Error("无效的 action 类型", zap.String("letterString", letterString), zap.String("action", string(l.Action)))
	}

}

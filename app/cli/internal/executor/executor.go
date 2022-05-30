package executor

import (
	"encoding/json"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cheerego/uci/protocol/letter"
	"github.com/go-resty/resty/v2"
	"go.uber.org/zap"
)

var E = NewExecutor()

type IExecutor interface {
	Start(payload *letter.StartPipelinePayload) (string, error)
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

func (o *Executor) Exec(dispatchMessage string) {
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
			raw, err := o.HostExecutor.Start(p)
			if err != nil {
				log.L().Error("after start", zap.Error(err))
				return
			}
			log.L().Info("raw", zap.String("raw", raw))
			client := resty.New()

			var result = make(map[string]interface{})
			resp, err := client.R().
				SetHeader("Content-Type", "application/json").
				SetBody(map[string]interface{}{
					"uuid": p.Uuid,
					"raw":  raw,
				}).
				SetResult(result).
				Post("http://messaging.uci.127.0.0.1.nip.io/api/v1/pipeline/report/log/raw")
			if err != nil {
				log.L().Error("report raw log err", zap.Error(err))
				return
			}
			if resp.StatusCode() != 200 {
				log.L().Error("report log raw status code != 200", zap.Any("result", result))
			}
		}()

	case letter.StopAction:
	default:
		log.L().Error("无效的 action 类型", zap.String("dispatchMessage", dispatchMessage), zap.String("action", string(l.Action)))
	}

}

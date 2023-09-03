package executor

import (
	"context"
	"encoding/json"
	"github.com/cheerego/uci/app/cli/internal/executor/host"
	"github.com/cheerego/uci/app/cli/internal/executor/storage"
	"github.com/cheerego/uci/app/cli/internal/requests"
	"github.com/cheerego/uci/frame/protocol/letter"
	"github.com/cheerego/uci/pkg/log"
	"go.uber.org/zap"
	"golang.org/x/sync/errgroup"
	"io"
	"os"
	"time"
)

var E = NewExecutor()

type IExecutor interface {
	Start(ctx context.Context, payload *letter.StartPipelinePayload, w io.WriteCloser) error
	//PrepareWorkspace(payload *payload.StartPipelinePayload) error
}

type PipelineExecRuntime struct {
	PipelineId uint32
	cancelFunc context.CancelFunc
}

func NewPipelineExecRuntime(pipelineId uint32, cancelFunc context.CancelFunc) *PipelineExecRuntime {
	return &PipelineExecRuntime{PipelineId: pipelineId, cancelFunc: cancelFunc}
}

type Executor struct {
	HostExecutor         IExecutor
	PipelineExecRuntimes map[uint32]*PipelineExecRuntime
}

func NewExecutor() *Executor {
	return &Executor{
		host.NewHostExecutor(),
		make(map[uint32]*PipelineExecRuntime),
	}
}

func (o *Executor) Exec(letterString string) {
	var l letter.Letter
	err := json.Unmarshal([]byte(letterString), &l)
	if err != nil {
		log.L().Error("json.Unmarshal letterString err", zap.Error(err), zap.String("letterString", letterString))
		return
	}

	log.S().Infof("ack ackId %s letter %s", l.AckId, letterString)

	switch l.Action {
	case letter.StartAction:
		payload, err := l.StartPipelinePayload()
		if err != nil {
			log.L().Error("parse start pipeline payload err", zap.Error(err), zap.Any("payload", l.Payload))
			return
		}
		err = o.startAction(payload)
		if err != nil {
			requests.PipelineBuildFailed(payload, err)
		} else {
			requests.PipelineBuildStatus(payload, "BUILD_SUCCEED")
		}
	case letter.StopAction:
		payload, err := l.StopPipelinePayload()
		if err != nil {
			log.L().Error("parse stop pipeline payload err", zap.Error(err), zap.Any("payload", l.Payload))
			return
		}
		err = o.stopAction(payload)

	default:
		log.L().Error("无效的 action 类型", zap.String("letterString", letterString), zap.String("action", string(l.Action)))
	}
}

func (o *Executor) stopAction(payload *letter.StopPipelinePayload) error {
	if cancel, ok := o.PipelineExecRuntimes[payload.PipelineId]; ok {
		cancel.cancelFunc()
	}
	return nil
}

func (o *Executor) startAction(p *letter.StartPipelinePayload) error {

	time.Sleep(2 * time.Second)
	err := requests.PipelineBuildStatus(p, "BUILD_RUNNING")
	if err != nil {
		return err
	}

	r, w, _ := os.Pipe()
	defer r.Close()

	g, ctx := errgroup.WithContext(context.Background())
	stopCtx, cancelFunc := context.WithCancel(ctx)

	g.Go(func() error {
		return storage.ReportRawlog(p, r)
	})
	g.Go(func() error {
		defer w.Close()
		o.PipelineExecRuntimes[p.PipelineId] = NewPipelineExecRuntime(p.PipelineId, cancelFunc)
		defer delete(o.PipelineExecRuntimes, p.PipelineId)
		return o.HostExecutor.Start(stopCtx, p, w)
	})
	return g.Wait()
}

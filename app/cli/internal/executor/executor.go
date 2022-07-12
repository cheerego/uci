package executor

import (
	"bufio"
	"context"
	"encoding/json"
	"fmt"
	"github.com/cheerego/uci/app/cli/internal/requests"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cheerego/uci/protocol/letter"
	"go.uber.org/zap"
	"golang.org/x/sync/errgroup"
	"io"
	"os"
	"time"
)

var E = NewExecutor()

type IExecutor interface {
	Start(ctx context.Context, payload *letter.StartPipelinePayload, w io.Writer) error
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
		NewHostExecutor(),
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

	r, w, err := os.Pipe()
	if err != nil {
		return err
	}
	defer r.Close()

	g, ctx := errgroup.WithContext(context.Background())
	cancel, cancelFunc := context.WithCancel(ctx)

	g.Go(func() error {
		return o.reportRawlog(p, r)
	})
	g.Go(func() error {
		defer w.Close()
		o.PipelineExecRuntimes[p.PipelineId] = NewPipelineExecRuntime(p.PipelineId, cancelFunc)
		defer delete(o.PipelineExecRuntimes, p.PipelineId)
		return o.HostExecutor.Start(cancel, p, w)
	})
	return g.Wait()
}

func (o *Executor) reportRawlog(p *letter.StartPipelinePayload, reader io.Reader) error {
	r := bufio.NewReader(reader)

	var rawCh = make(chan string, 100)
	g, _ := errgroup.WithContext(context.TODO())
	g.Go(func() error {
		raws := ""
		for {
			select {
			case <-time.After(5 * time.Second):
				err := requests.PipelineRawlog(p.Uuid, true, raws)
				if err != nil {
					log.L().Error("1", zap.String("pipeline", p.String()), zap.Error(err))
				}
				raws = ""
			case raw, ok := <-rawCh:
				if ok {
					raws = fmt.Sprintf("%s%s", raws, raw)
				} else {
					err := requests.PipelineRawlog(p.Uuid, true, raws)
					if err != nil {
						log.L().Error("1", zap.String("pipeline", p.String()), zap.Error(err))
					} else {
						log.L().Info("read raw end", zap.String("pipeline", p.String()))
					}
					return nil
				}
			}
		}
	})

	g.Go(func() error {
		defer close(rawCh)
		for {
			str, err := r.ReadString('\n')
			if len(str) > 0 {
				rawCh <- str
			}
			if err == io.EOF {
				return nil
			}
			if err != nil {
				rawCh <- str
				return err
			}
		}
	})
	return g.Wait()
}

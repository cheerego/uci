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
	"sync"
	"time"
)

var E = NewExecutor()

type IExecutor interface {
	Start(ctx context.Context, payload *letter.StartPipelinePayload, w io.Writer) error
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
		o.startAction(ctx, p)

	case letter.StopAction:
	default:
		log.L().Error("无效的 action 类型", zap.String("letterString", letterString), zap.String("action", string(l.Action)))
	}

}
func (o *Executor) startAction(ctx context.Context, p *letter.StartPipelinePayload) {
	var err error
	defer func() {
		o.reportPipelineFinished(ctx, p, err)
	}()
	time.Sleep(2 * time.Second)
	err = o.reportPipelineRunning(ctx, p)
	if err != nil {
		log.L().Error("report pipeline status BUILD_RUNNING", zap.String("pipeline", p.LogName()))
		return
	}

	r, w, err := os.Pipe()
	if err != nil {
		return
	}
	defer r.Close()
	defer w.Close()

	g, ctx := errgroup.WithContext(ctx)
	g.Go(func() error {
		return o.reportRawlog(ctx, p, r)
	})

	g.Go(func() error {
		err = o.HostExecutor.Start(ctx, p, w)
		if err != nil {
			log.L().Error("report pipeline finish err", zap.Error(err))
		}
		return err
	})

	err = g.Wait()
	if err != nil {
		log.L().Error("wait group err", zap.Error(err))
	}

}

func (o *Executor) reportPipelineRunning(ctx context.Context, p *letter.StartPipelinePayload) error {
	err := requests.ReportPipelineStatus(ctx, p.Uuid, "BUILD_RUNNING", "")
	return err
}

func (o *Executor) reportPipelineFinished(ctx context.Context, p *letter.StartPipelinePayload, err error) error {
	if err != nil {
		err = requests.ReportPipelineStatus(ctx, p.Uuid, "BUILD_FAILED", err.Error())
	} else {
		err = requests.ReportPipelineStatus(ctx, p.Uuid, "BUILD_SUCCEED", "")
	}
	return err
}

func (o *Executor) reportRawlog(ctx context.Context, p *letter.StartPipelinePayload, reader io.Reader) error {
	r := bufio.NewReader(reader)
	mutex := sync.Mutex{}
	ticker := time.NewTicker(5 * time.Second)
	defer ticker.Stop()

	var report bool = false
	go func() {
		for {
			select {
			case <-ticker.C:
				mutex.Lock()
				report = true
				mutex.Unlock()
			}
		}
	}()
	strs := ""

	for {
		if len(strs) > 0 && report {
			err := requests.ReportRawlog(context.TODO(), p.Uuid, true, strs)
			log.L().Error("1", zap.Error(err))
			strs = ""
			mutex.Lock()
			report = false
			mutex.Unlock()
		}

		str, err := r.ReadString('\n')
		if len(str) > 0 {
			strs = fmt.Sprintf("%s\n%s", strs, str)
		}
		if err == io.EOF {
			requests.ReportRawlog(context.TODO(), p.Uuid, true, strs)
			return nil
		}
		if err != nil {
			requests.ReportRawlog(context.TODO(), p.Uuid, true, strs)
			return err
		}
	}

}

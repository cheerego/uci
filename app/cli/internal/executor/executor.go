package executor

import (
	"bufio"
	"context"
	"encoding/json"
	"fmt"
	"github.com/cheerego/uci/app/cli/internal/config"
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

type Executor struct {
	HostExecutor IExecutor
}

func NewExecutor() *Executor {
	return &Executor{
		NewHostExecutor(),
	}
}

func (o *Executor) Exec(letterString string) {
	var l letter.Letter
	err := json.Unmarshal([]byte(letterString), &l)
	if err != nil {
		log.L().Error("json.Unmarshal letterString err", zap.Error(err), zap.String("letterString", letterString))
		return
	}

	ctx := context.Background()
	switch l.Action {
	case letter.StartAction:
		p, err := l.StartPipelinePayload()
		if err != nil {
			log.L().Error("parse start pipeline payload err", zap.Error(err))
			return
		}
		err = o.startAction(ctx, p)
		o.reportPipelineFinished(p, err)
	case letter.StopAction:
	default:
		log.L().Error("无效的 action 类型", zap.String("letterString", letterString), zap.String("action", string(l.Action)))
	}

}
func (o *Executor) startAction(ctx context.Context, p *letter.StartPipelinePayload) error {

	time.Sleep(2 * time.Second)
	err := o.reportPipelineRunning(p)
	if err != nil {
		return err
	}

	r, w, err := os.Pipe()
	if err != nil {
		return err
	}
	defer r.Close()

	g, _ := errgroup.WithContext(ctx)
	g.Go(func() error {
		return o.reportRawlog(p, r)
	})

	g.Go(func() error {
		defer w.Close()
		value, err := config.UciDispatchModeItem.Value()
		log.L().Info("dispatch mode", zap.String("pipeline", p.LogName()), zap.String("dispatchMode", value), zap.Error(err))
		return o.HostExecutor.Start(ctx, p, w)
	})

	return g.Wait()
}

func (o *Executor) reportPipelineRunning(p *letter.StartPipelinePayload) error {
	err := requests.ReportPipelineStatus(p.Uuid, "BUILD_RUNNING", "")
	return err
}

func (o *Executor) reportPipelineFinished(p *letter.StartPipelinePayload, err error) error {
	if err != nil {
		err = requests.ReportPipelineStatus(p.Uuid, "BUILD_FAILED", err.Error())
	} else {
		err = requests.ReportPipelineStatus(p.Uuid, "BUILD_SUCCEED", "")
	}
	return err
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
				err := requests.ReportRawlog(p.Uuid, true, raws)
				if err != nil {
					log.L().Error("1", zap.String("pipeline", p.LogName()), zap.Error(err))
				}
				raws = ""
			case raw, ok := <-rawCh:
				if ok {
					raws = fmt.Sprintf("%s%s", raws, raw)
				} else {
					err := requests.ReportRawlog(p.Uuid, true, raws)
					if err != nil {
						log.L().Error("1", zap.String("pipeline", p.LogName()), zap.Error(err))
					} else {
						log.L().Info("read raw end", zap.String("pipeline", p.LogName()))
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

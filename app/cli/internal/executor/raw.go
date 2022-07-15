package executor

import (
	"bufio"
	"context"
	"fmt"
	"github.com/cheerego/uci/app/cli/internal/requests"
	"github.com/cheerego/uci/frame/protocol/letter"
	"github.com/cheerego/uci/pkg/log"
	"go.uber.org/zap"
	"golang.org/x/sync/errgroup"
	"io"
	"time"
)

func reportRawlog(p *letter.StartPipelinePayload, reader io.Reader) error {
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

func stepLog(p *letter.StartPipelinePayload, reader io.Reader) error {
	r := bufio.NewReader(reader)

	var rawCh = make(chan string, 100)
	g, _ := errgroup.WithContext(context.TODO())
	g.Go(func() error {
		raws := ""
		for {
			select {
			case <-time.After(5 * time.Second):
				raws = ""
			case raw, ok := <-rawCh:
				if ok {
					raws = fmt.Sprintf("%s%s", raws, raw)
					log.S().Info("step log %s", raws)
				} else {
					log.L().Info("read raw end", zap.String("pipeline", p.String()))
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

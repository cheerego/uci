package collector

import (
	"bufio"
	"context"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cheerego/uci/protocol/letter"
	"go.uber.org/zap"
	"golang.org/x/sync/errgroup"
	"io"
	"strings"
	"sync"
	"time"
)

type Collector struct {
}

func NewCollector() *Collector {
	return &Collector{}
}

func (c *Collector) CollectorRawlog(ctx context.Context, payload *letter.StartPipelinePayload, reader io.Reader) error {
	r := bufio.NewReader(reader)
	var rwlock = sync.RWMutex{}
	strs := make([]string, 1000, 1500)

	g, gctx := errgroup.WithContext(ctx)

	contentLen := 0
	g.Go(func() error {
		for {
			str, err := r.ReadString('\n')
			if len(str) > 0 {
				log.L().Info("1", zap.String("pipeline", payload.LogName()), zap.String("str", str))
				func() {
					rwlock.Lock()
					defer rwlock.Unlock()
					strs = append(strs, str)
					contentLen++
				}()

			}
			if err == io.EOF {
				log.L().Info("eof", zap.String("pipeline", payload.LogName()), zap.String("str", str))
				return err
			}
			if err != nil {
				return err
			}
		}
	})

	g.Go(func() error {
		ticker := time.NewTicker(5 * time.Second)
		defer ticker.Stop()

		var read = func() {
			var raw string
			func() {
				rwlock.Lock()
				defer rwlock.Unlock()
				raw = strings.Join(strs[:contentLen], "")
				strs = strs[contentLen+1:]
				contentLen = 0
			}()
			log.L().Info("raw", zap.String("pipeline", payload.LogName()), zap.String("raw", raw))
		}

		for {
			select {
			case <-gctx.Done():
				log.L().Info("done", zap.String("pipeline", payload.LogName()))
				read()
				return nil
			case <-ticker.C:
				log.L().Info("ticker", zap.String("pipeline", payload.LogName()))
				read()
			}
		}

	})
	return g.Wait()
}

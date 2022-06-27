package collector

import (
	"bufio"
	"context"
	"fmt"
	"github.com/cheerego/uci/app/cli/internal/requests"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cheerego/uci/protocol/letter"
	"go.uber.org/zap"
	"io"
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
			err := requests.ReportRawlog(context.TODO(), payload.Uuid, true, strs)
			log.L().Error("1", zap.Error(err))
			strs = ""
			mutex.Lock()
			report = false
			mutex.Unlock()
		}

		str, err := r.ReadString('\n')
		if len(str) > 0 {
			log.L().Info("read", zap.String("str", str))
			strs = fmt.Sprintf("%s%s", strs, str)
		}
		if err == io.EOF {
			err := requests.ReportRawlog(context.TODO(), payload.Uuid, true, strs)
			return err
		}
		if err != nil {
			err := requests.ReportRawlog(context.TODO(), payload.Uuid, true, strs)
			return err
		}
	}
}

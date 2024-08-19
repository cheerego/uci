package conyer

import (
	"context"
	"github.com/assembla/cony"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/phase"
	"github.com/cheerego/uci/pkg/log"
	"github.com/streadway/amqp"
	"go.uber.org/zap"
	"strconv"
)

type WaitForDispatchingListener struct {
}

func NewWaitForDispatchingListener() *WaitForDispatchingListener {
	return &WaitForDispatchingListener{}
}

func (w *WaitForDispatchingListener) ConnectionSize() int {
	return 2
}

func (w *WaitForDispatchingListener) Concurrent() int {
	return 20
}

func (w *WaitForDispatchingListener) Handle(msg amqp.Delivery) {
	atoi, err := strconv.Atoi(string(msg.Body))
	if err != nil {
		log.Error("wait for dispatching consumer, parseInt err", zap.Error(err), zap.String("value", string(msg.Body)))
		return
	}
	ctx := context.TODO()

	err = phase.Phases()[pipeline.WaitForDispatching].Exec(ctx, int64(atoi))
	if err != nil {
		log.Error("wait for dispatching, phase exec err", zap.Error(err), zap.Int("pipelineId", atoi))
		return
	}
}

func (w *WaitForDispatchingListener) Consumer() *cony.Consumer {
	return WaitForDispatchingConsumer
}

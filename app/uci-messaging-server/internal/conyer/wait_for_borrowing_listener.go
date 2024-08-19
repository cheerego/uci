package conyer

import (
	"context"
	"errors"
	"github.com/assembla/cony"
	godisson "github.com/cheerego/go-redisson"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/phase"
	"github.com/cheerego/uci/pkg/log"
	"github.com/streadway/amqp"
	"go.uber.org/zap"
	"strconv"
)

type WaitForBorrowingListener struct {
}

func NewWaitForBorrowingListener() *WaitForBorrowingListener {
	return &WaitForBorrowingListener{}
}

func (w *WaitForBorrowingListener) ConnectionSize() int {
	return 2
}

func (w *WaitForBorrowingListener) Concurrent() int {
	return 20
}

func (w *WaitForBorrowingListener) Handle(msg amqp.Delivery) {
	atoi, err := strconv.Atoi(string(msg.Body))
	if err != nil {
		log.Error("wait for borrowing consumer, parseInt err", zap.Error(err), zap.String("value", string(msg.Body)))
		return
	}
	ctx := context.TODO()

	err = phase.Phases()[pipeline.WaitForBorrowing].Exec(ctx, int64(atoi))
	if err != nil {
		if !errors.Is(err, godisson.ErrLockNotObtained) {
			log.Warn("wait for borrowing, phase exec err", zap.Uint32("pipelineId", uint32(atoi)), zap.String("body", string(msg.Body)), zap.String("error", err.Error()))
		}
		return
	}
}

func (w *WaitForBorrowingListener) Consumer() *cony.Consumer {
	return WaitForBorrowingConsumer
}

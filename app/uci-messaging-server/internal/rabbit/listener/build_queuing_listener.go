package listener

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

type BuildQueuingListener struct {
}

func NewBuildQueuingListener() *BuildQueuingListener {
	return &BuildQueuingListener{}
}

func (b *BuildQueuingListener) Handle(msg amqp.Delivery) {
	atoi, err := strconv.Atoi(string(msg.Body))
	if err != nil {
		log.L().Error("build queuing consumer, parseInt err", zap.Error(err), zap.String("value", string(msg.Body)))
		return
	}
	ctx := context.TODO()

	err = phase.Phases()[pipeline.BuildQueuing].Exec(ctx, uint32(atoi))
	if err != nil {
		log.L().Error("build queuing consumer, phase exec err", zap.Error(err), zap.Int("value", atoi))
		return
	}
}

func (b *BuildQueuingListener) Concurrent() int {
	return 20
}

func (b *BuildQueuingListener) ConnectionSize() int {
	return 2
}

func (b *BuildQueuingListener) Consumer() *cony.Consumer {
	return BuildQueuingConsumer
}

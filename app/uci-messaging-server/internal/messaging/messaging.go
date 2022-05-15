package messaging

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/config"
	"github.com/wagslane/go-rabbitmq"
	"go.uber.org/zap"
)

var Messagings *Messaging

type Messaging struct {
	Publisher *rabbitmq.Publisher
}

func (m *Messaging) NewConsumer() (rabbitmq.Consumer, error) {
	return rabbitmq.NewConsumer(
		config.Configs.RabbitMQAddrUrl, rabbitmq.Config{},
		rabbitmq.WithConsumerOptionsLogging,
	)
}

func NewMessaging(publisher *rabbitmq.Publisher) *Messaging {
	return &Messaging{Publisher: publisher}
}

func init() {
	publisher, err := rabbitmq.NewPublisher(
		config.Configs.RabbitMQAddrUrl, rabbitmq.Config{},
	)
	if err != nil {
		zap.L().Fatal("connect rabbitmq, new publisher err", zap.Error(err))
	}
	Messagings = NewMessaging(publisher)
}

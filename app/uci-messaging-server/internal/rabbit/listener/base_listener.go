package listener

import (
	"github.com/assembla/cony"
	"github.com/streadway/amqp"
)

type IListener interface {
	ConnectionSize() int
	Concurrent() int
	Handle(delivery amqp.Delivery)
	Consumer() *cony.Consumer
}
type BaseListener struct {
	IConsumer IListener
}

func NewBaseListener(IConsumer IListener) *BaseListener {
	return &BaseListener{IConsumer: IConsumer}
}

func (b *BaseListener) Handler() {
	consumer := b.IConsumer.Consumer()

	for size := 0; size < b.IConsumer.ConnectionSize(); size++ {
		for concurrent := 0; concurrent < b.IConsumer.Concurrent(); concurrent++ {
			go func() {
				for delivery := range consumer.Deliveries() {
					b.IConsumer.Handle(delivery)
				}
			}()

		}
	}

}

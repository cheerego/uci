package messaging

//var Messagings *Messaging
//
//type Messaging struct {
//	Publisher *rabbitmq.Publisher
//}
//
//func (m *Messaging) NewConsumer() (rabbitmq.Consumer, error) {
//	return rabbitmq.NewConsumer(
//		config.Configs.RabbitAddrUrl, rabbitmq.Config{},
//		rabbitmq.WithConsumerOptionsLogging,
//	)
//}
//
//func NewMessaging(publisher *rabbitmq.Publisher) *Messaging {
//	return &Messaging{Publisher: publisher}
//}
//
//func init() {
//	publisher, err := rabbitmq.NewPublisher(
//		config.Configs.RabbitAddrUrl, rabbitmq.Config{},
//	)
//	if err != nil {
//	}
//	Messagings = NewMessaging(publisher)
//}

package rabbit

import (
	"github.com/assembla/cony"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/rabbit/declare"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/rabbit/listener"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/rabbit/publisher"
)

var Cli *cony.Client

func New(opt ...cony.ClientOpt) *cony.Client {
	Cli = cony.NewClient(opt...)

	Cli.Declare([]cony.Declaration{
		cony.DeclareExchange(declare.UciInternalExchange),
		cony.DeclareQueue(declare.BuildQueuingPhaseQueue),
		cony.DeclareQueue(declare.WaitForBorrowingPhaseQueue),
		cony.DeclareQueue(declare.WaitForDispatchingPhaseQueue),
		cony.DeclareBinding(declare.UciInternalExchangeAndBuildQueuingPhaseQueueBinding),
		cony.DeclareBinding(declare.UciInternalExchangeAndWaitForBorrowingPhaseQueueBinding),
		cony.DeclareBinding(declare.UciInternalExchangeAndWaitForDispatchingPhaseQueueBinding),
	})
	Cli.Consume(listener.BuildQueuingConsumer)
	Cli.Consume(listener.WaitForBorrowingConsumer)
	Cli.Consume(listener.WaitForDispatchingConsumer)

	Cli.Publish(publisher.BuildQueuingPublisher)
	Cli.Publish(publisher.WaitForBorrowingPublisher)
	Cli.Publish(publisher.WaitForDispatchingPublisher)

	listener.NewBaseListener(listener.NewBuildQueuingListener()).Handler()
	listener.NewBaseListener(listener.NewWaitForBorrowingListener()).Handler()
	listener.NewBaseListener(listener.NewWaitForDispatchingListener()).Handler()

	return Cli
}

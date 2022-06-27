package conyer

import "github.com/assembla/cony"

var Cli *cony.Client

func New(opt ...cony.ClientOpt) *cony.Client {
	Cli = cony.NewClient(opt...)

	Cli.Declare([]cony.Declaration{
		cony.DeclareExchange(UciInternalExchange),
		cony.DeclareQueue(BuildQueuingPhaseQueue),
		cony.DeclareQueue(WaitForBorrowingPhaseQueue),
		cony.DeclareQueue(WaitForDispatchingPhaseQueue),
		cony.DeclareBinding(UciInternalExchangeAndBuildQueuingPhaseQueueBinding),
		cony.DeclareBinding(UciInternalExchangeAndWaitForBorrowingPhaseQueueBinding),
		cony.DeclareBinding(UciInternalExchangeAndWaitForDispatchingPhaseQueueBinding),
	})
	Cli.Consume(BuildQueuingConsumer)
	Cli.Consume(WaitForBorrowingConsumer)
	Cli.Consume(WaitForDispatchingConsumer)

	Cli.Publish(BuildQueuingPublisher)
	Cli.Publish(WaitForBorrowingPublisher)
	Cli.Publish(WaitForDispatchingPublisher)

	NewBaseListener(NewBuildQueuingListener()).Handler()
	NewBaseListener(NewWaitForBorrowingListener()).Handler()
	NewBaseListener(NewWaitForDispatchingListener()).Handler()

	return Cli
}

package conyer

import "github.com/assembla/cony"

var BuildQueuingConsumer = cony.NewConsumer(
	BuildQueuingPhaseQueue,
	cony.AutoAck(), // Auto sign the deliveries
	cony.AutoTag(),
	cony.Qos(20),
)

var WaitForBorrowingConsumer = cony.NewConsumer(
	WaitForBorrowingPhaseQueue,
	cony.AutoAck(), // Auto sign the deliveries
	cony.AutoTag(),
	cony.Qos(20),
)

var WaitForDispatchingConsumer = cony.NewConsumer(
	WaitForDispatchingPhaseQueue,
	cony.AutoAck(), // Auto sign the deliveries
	cony.AutoTag(),
	cony.Qos(20),
)

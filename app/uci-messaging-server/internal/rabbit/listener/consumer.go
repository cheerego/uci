package listener

import (
	"github.com/assembla/cony"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/rabbit/declare"
)

var BuildQueuingConsumer = cony.NewConsumer(
	declare.BuildQueuingPhaseQueue,
	cony.AutoAck(), // Auto sign the deliveries
	cony.AutoTag(),
	cony.Qos(20),
)

var WaitForBorrowingConsumer = cony.NewConsumer(
	declare.WaitForBorrowingPhaseQueue,
	cony.AutoAck(), // Auto sign the deliveries
	cony.AutoTag(),
	cony.Qos(20),
)

var WaitForDispatchingConsumer = cony.NewConsumer(
	declare.WaitForDispatchingPhaseQueue,
	cony.AutoAck(), // Auto sign the deliveries
	cony.AutoTag(),
	cony.Qos(20),
)

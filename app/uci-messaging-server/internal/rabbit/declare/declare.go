package declare

import (
	"github.com/assembla/cony"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
)

// 交换机

var UciInternalExchange = cony.Exchange{
	Name:       "uci.internal.exchange",
	Kind:       "direct",
	Durable:    true,
	AutoDelete: false,
	Args:       nil,
}

// BuildQueuingPhaseQueue
// pipeline_build_queuing_phase
var BuildQueuingPhaseQueue = &cony.Queue{
	Name:       "pipeline_build_queuing_phase",
	Durable:    true,
	AutoDelete: false,
	Exclusive:  false,
	Args:       nil,
}

var UciInternalExchangeAndBuildQueuingPhaseQueueBinding = cony.Binding{
	Queue:    BuildQueuingPhaseQueue,
	Exchange: UciInternalExchange,
	Key:      string(pipeline.BuildQueuing),
	Args:     nil,
}

//WaitForBorrowingPhaseQueue
// pipeline_wait_for_borrowing_phase
var WaitForBorrowingPhaseQueue = &cony.Queue{
	Name:       "pipeline_wait_for_borrowing_phase",
	Durable:    true,
	AutoDelete: false,
	Exclusive:  false,
	Args:       nil,
}

var UciInternalExchangeAndWaitForBorrowingPhaseQueueBinding = cony.Binding{
	Queue:    WaitForBorrowingPhaseQueue,
	Exchange: UciInternalExchange,
	Key:      string(pipeline.WaitForBorrowing),
	Args:     nil,
}

//WaitForDispatchingPhaseQueue
// pipeline_wait_for_dispatching_phase
var WaitForDispatchingPhaseQueue = &cony.Queue{
	Name:       "pipeline_wait_for_dispatching_phase",
	Durable:    true,
	AutoDelete: false,
	Exclusive:  false,
	Args:       nil,
}

var UciInternalExchangeAndWaitForDispatchingPhaseQueueBinding = cony.Binding{
	Queue:    WaitForDispatchingPhaseQueue,
	Exchange: UciInternalExchange,
	Key:      string(pipeline.WaitForDispatching),
	Args:     nil,
}

package conyer

import (
	"github.com/assembla/cony"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
)

var BuildQueuingPublisher = cony.NewPublisher(UciInternalExchange.Name, string(pipeline.BuildQueuing))
var WaitForBorrowingPublisher = cony.NewPublisher(UciInternalExchange.Name, string(pipeline.WaitForBorrowing))
var WaitForDispatchingPublisher = cony.NewPublisher(UciInternalExchange.Name, string(pipeline.WaitForDispatching))

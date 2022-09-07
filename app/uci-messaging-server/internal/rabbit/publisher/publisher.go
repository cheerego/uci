package publisher

import (
	"github.com/assembla/cony"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/rabbit/declare"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cheerego/uci/protocol/status"
	"github.com/cockroachdb/errors"
	"go.uber.org/zap"
)

var BuildQueuingPublisher = cony.NewPublisher(declare.UciInternalExchange.Name, string(pipeline.BuildQueuing))
var WaitForBorrowingPublisher = cony.NewPublisher(declare.UciInternalExchange.Name, string(pipeline.WaitForBorrowing))
var WaitForDispatchingPublisher = cony.NewPublisher(declare.UciInternalExchange.Name, string(pipeline.WaitForDispatching))

var Publishers map[status.Status]*cony.Publisher = map[status.Status]*cony.Publisher{
	pipeline.BuildQueuing:       BuildQueuingPublisher,
	pipeline.WaitForBorrowing:   WaitForBorrowingPublisher,
	pipeline.WaitForDispatching: WaitForDispatchingPublisher,
}

func SwitchPublisher(status pipeline.Status) (*cony.Publisher, error) {
	p, ok := Publishers[status]
	if ok {
		return p, nil
	}
	log.L().Error("", zap.String("status", string(status)))
	return nil, errors.Newf("get publisher by status %s not found", string(status))
}

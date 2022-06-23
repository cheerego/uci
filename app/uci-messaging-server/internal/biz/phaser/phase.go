package phaser

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
)

type Phaser interface {
	Exec(ctx context.Context, p *pipeline.Pipeline) error
}

var Phases = map[pipeline.Status]Phaser{
	pipeline.BuildQueuing:       NewBuildQueuingPhase(),
	pipeline.WaitForBorrowing:   NewWaitForBorrowingPhase(),
	pipeline.WaitForDispatching: NewWaitForDispatchingPhase(),
}

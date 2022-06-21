package phaser

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
)

type Phase interface {
	Exec(ctx context.Context, p *pipeline.Pipeline) error
}

var Phases = map[pipeline.Status]Phase{
	pipeline.BuildQueuing:     NewQueuingPhase(),
	pipeline.WaitForBorrowing: NewWaitForBorrowing(),
}

package messaging

import (
	"context"
	"go.etcd.io/bbolt"
	"golang.org/x/sync/errgroup"
)

type Shimer interface {
	Listening(ctx context.Context) error
	Consuming(ctx context.Context) error
}

type BaseShimer struct {
	_ *bbolt.DB
	Shimer
}

func NewBaseShimer(shimer Shimer) *BaseShimer {
	return &BaseShimer{Shimer: shimer}
}

var dbName = "uci-runner.db"

func (b *BaseShimer) Run(ctx context.Context) error {
	g, _ := errgroup.WithContext(ctx)
	g.Go(func() error {
		return b.Shimer.Listening(ctx)
	})
	g.Go(func() error {
		return b.Shimer.Consuming(ctx)
	})

	if err := g.Wait(); err != nil {
		return err
	}
	return nil
}

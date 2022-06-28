package messaging

import (
	"context"
	"github.com/cheerego/uci/app/cli/internal/executor"
	"github.com/cheerego/uci/app/cli/internal/uerror"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cockroachdb/errors"
	"go.uber.org/zap"
	"golang.org/x/sync/errgroup"
	"time"
)

type Shimer interface {
	Listening(ctx context.Context) error
	MessageChan() <-chan string
}

type BaseShimer struct {
	//Bbolt *bbolt.DB
	Shimer
}

func NewBaseShimer(shimer Shimer) *BaseShimer {
	//bbolt.Open(path.Join(dir.HomeDir(), config.Name, "uci.db"), 0666)
	return &BaseShimer{
		shimer,
	}
}

var dbName = "uci-runner.db"

func (b *BaseShimer) Pinging(ctx context.Context) error {
	ticker := time.NewTicker(5 * time.Second)
	defer ticker.Stop()
	for {
		select {
		case <-ticker.C:
			log.L().Info("pinging")
		case <-ctx.Done():
			return uerror.ErrContextCanceledOrTimeout.WithStack()
		}
	}
}
func (b *BaseShimer) Consuming(ctx context.Context) error {
	for {
		select {
		case <-ctx.Done():
			log.L().Info("base shimer consuming canceled")
			return uerror.ErrContextCanceledOrTimeout.WithStack()
		case msg, ok := <-b.Shimer.MessageChan():
			if !ok {
				return errors.New("list watch consuming select chan return no ok")
			}
			log.L().Info("list watch consuming receive message from chan ", zap.String("msg", msg))
			go executor.E.Exec(msg)
		}
	}
}

func (b *BaseShimer) Run(ctx context.Context) error {
	g, gctx := errgroup.WithContext(ctx)
	g.Go(func() error {
		return b.Shimer.Listening(gctx)
	})
	g.Go(func() error {
		return b.Consuming(gctx)
	})
	//g.Go(func() error {
	//	return b.Pinging(gctx)
	//})

	if err := g.Wait(); err != nil {
		return err
	}
	return nil
}

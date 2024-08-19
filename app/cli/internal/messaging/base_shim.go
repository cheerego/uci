package messaging

import (
	"context"
	"github.com/cheerego/uci/app/cli/internal/executor"
	"github.com/cheerego/uci/app/cli/internal/uerror"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cockroachdb/errors"
	"golang.org/x/sync/errgroup"
	"time"
)

type Shimer interface {
	Listening(ctx context.Context) error
	MessageChan() <-chan string
	Ack(msg string) error
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

var dbName = "uci-uci-uci-runner.db"

func (b *BaseShimer) Pinging(ctx context.Context) error {
	ticker := time.NewTicker(5 * time.Second)
	defer ticker.Stop()
	for {
		select {
		case <-ticker.C:
			log.Info("pinging")
		case <-ctx.Done():
			return uerror.ErrContextCanceledOrTimeout.WithStack()
		}
	}
}
func (b *BaseShimer) Consuming(ctx context.Context) error {
	for {
		select {
		case <-ctx.Done():
			log.Info("base shimer consuming canceled")
			return uerror.ErrContextCanceledOrTimeout.WithStack()
		case msg, ok := <-b.Shimer.MessageChan():
			if !ok {
				return errors.New("list watch consuming select chan return no ok")
			}
			err := b.Ack(msg)
			if err != nil {
				log.Infof("list watch ack receive message from chan %s err %v", msg, err)
				continue
			}
			log.Infof("list watch consuming receive message from chan %s", msg)
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

	if err := g.Wait(); err != nil {
		return err
	}
	return nil
}

package runner

import (
	"context"
	"github.com/cheerego/uci/app/runner/internal/route"
	"github.com/cheerego/uci/pkg/http"
	"github.com/cheerego/uci/pkg/uerror"
	"github.com/cheerego/uci/pkg/z/backend"
	"github.com/cockroachdb/errors"
	"go.uber.org/zap"
	"golang.org/x/sync/errgroup"
)

type Application struct {
}

func NewApplication() *Application {
	return &Application{}
}

func (a *Application) Start(ctx context.Context, cancel context.CancelFunc) error {
	err := errors.CombineErrors(a.ConfigLog(), nil)
	if err != nil {
		return err
	}
	g, _ := errgroup.WithContext(ctx)
	g.Go(a.startHttp)
	return g.Wait()
}

func (a *Application) startHttp() error {
	engine := http.NewEcho()
	route.Routes(engine)
	engine.HTTPErrorHandler = uerror.TextHttpErrorHandler(engine)
	return engine.Start(":8081")
}

func (a *Application) ConfigLog() error {
	configuration, err := backend.Configuration()
	if err != nil {
		return err
	}
	zap.ReplaceGlobals(configuration)
	return nil
}

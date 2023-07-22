package runner

import (
	"context"
	"github.com/cheerego/uci/app/runner/internal/route"
	"github.com/cheerego/uci/pkg/http"
	"github.com/cheerego/uci/pkg/uerror"
	"golang.org/x/sync/errgroup"
)

type Application struct {
}

func NewApplication() *Application {
	return &Application{}
}

func (a *Application) Start(ctx context.Context, cancel context.CancelFunc) error {
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

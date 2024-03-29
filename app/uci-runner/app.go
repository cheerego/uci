package uci_runner

import (
	"context"
	"github.com/cheerego/uci/app/uci-runner/internal/route"
	"github.com/cheerego/uci/pkg/http"
	"github.com/cheerego/uci/pkg/log/backend"
	signal2 "github.com/cheerego/uci/pkg/signal"
	"github.com/cheerego/uci/pkg/uerror"
	"github.com/cockroachdb/errors"
	"github.com/go-playground/validator"
	"github.com/labstack/echo/v4"
	"go.uber.org/zap"
	"golang.org/x/sync/errgroup"
	http2 "net/http"
)

type Application struct {
	engine *echo.Echo
}

func NewApplication() *Application {
	return &Application{}
}

func (a *Application) Start() error {
	err := errors.CombineErrors(a.ConfigLog(), nil)
	if err != nil {
		return err
	}
	ctx, cancel := context.WithCancel(context.Background())
	g, gctx := errgroup.WithContext(ctx)
	g.Go(a.startHttp)

	g.Go(func() error {
		<-gctx.Done()
		return a.engine.Shutdown(gctx)
	})
	//
	//waiting exit signal
	g.Go(func() error {
		quit := signal2.KillSignal()
		select {
		case <-gctx.Done():
			return gctx.Err()
		case <-quit:
			cancel()
			return errors.New("ErrExitSignal1")
		}
	})
	return g.Wait()
}

func (a *Application) startHttp() error {
	engine := http.NewEcho()
	a.engine = engine
	engine.Validator = &CustomValidator{validator: validator.New()}
	route.Routes(engine)
	engine.HTTPErrorHandler = uerror.TextHttpErrorHandler(engine)
	return engine.Start(":8081")
}

type CustomValidator struct {
	validator *validator.Validate
}

func (cv *CustomValidator) Validate(i interface{}) error {
	if err := cv.validator.Struct(i); err != nil {
		return echo.NewHTTPError(http2.StatusBadRequest, err.Error()).SetInternal(err)
	}
	return nil
}

func (a *Application) ConfigLog() error {
	configuration, err := backend.Configuration()
	if err != nil {
		return err
	}
	zap.ReplaceGlobals(configuration)
	return nil
}

package uci_messaging_server

import (
	"context"
	"errors"
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/config"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/web"
	"github.com/cheerego/uci/pkg/http"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cheerego/uci/pkg/signal"
	"github.com/cheerego/uci/pkg/tracing"
	"github.com/cheerego/uci/pkg/uerror"
	"github.com/go-co-op/gocron"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	uuid "github.com/satori/go.uuid"
	"go.opentelemetry.io/contrib/instrumentation/github.com/labstack/echo/otelecho"
	"go.opentelemetry.io/otel/trace"
	"go.uber.org/zap"
	"golang.org/x/sync/errgroup"
	"time"
)

type Application struct {
}

func NewApplication() *Application {
	return &Application{}
}

func (a *Application) Start(ctx context.Context) error {
	if tracing.EnableTracing() {
		err := a.startTracing(ctx)()
		if err != nil {
			return err
		}
	}
	g, _ := errgroup.WithContext(ctx)
	g.Go(a.startHttp)
	g.Go(a.startGrpc)
	g.Go(a.startCron)

	g.Go(func() error {
		killSignal := signal.KillSignal()
		<-killSignal
		return errors.New("kill signal")
	})
	return g.Wait()
}

func (a *Application) startHttp() error {
	o := http.NewEcho()
	if tracing.EnableTracing() {
		o.Use(otelecho.Middleware("uci-messaging-server"))
	}
	o.Use(middleware.RequestIDWithConfig(middleware.RequestIDConfig{
		Generator: func() string {
			return uuid.NewV4().String()
		},
		RequestIDHandler: func(c echo.Context, s string) {
			span := trace.SpanFromContext(c.Request().Context())
			if span.SpanContext().IsValid() && span.SpanContext().HasTraceID() {
				zap.L().Info("has traceid")
				s = span.SpanContext().TraceID().String()
			}
			c.Response().Header().Set(echo.HeaderXRequestID, s)
			c.Request().Header.Set(echo.HeaderXRequestID, s)
			c.Set(echo.HeaderXRequestID, s)
			r := c.Request().WithContext(context.WithValue(c.Request().Context(), echo.HeaderXRequestID, s))
			c.SetRequest(r)
		},
	}))
	o.Debug = true
	o.HTTPErrorHandler = uerror.JSONHttpErrorHandler(o)
	web.Route(o)
	web.WS(o)
	return o.Start(fmt.Sprintf(":%d", config.Configs.HttpPort))
}

func (a *Application) startGrpc() error {
	return nil
}

func (a *Application) startCron() error {
	location, err := time.LoadLocation("Asia/Shanghai")
	if err != nil {
		return err
	}
	s := gocron.NewScheduler(location)
	s.StartBlocking()
	return nil
}
func (a *Application) startTracing(ctx context.Context) func() error {
	log.S().Infof("start tracing")
	return func() error {
		trace, err := tracing.Trace(ctx, "uci-messaging-server")
		if err != nil {
			return err
		}
		pusher, err := tracing.Metric(ctx, 5*time.Second)
		if err != nil {
			return err
		}
		err = pusher.Start(ctx)
		if err != nil {
			return err
		}
		go func() {
			killSignal := signal.KillSignal()
			<-killSignal
			timeout, cancelFunc := context.WithTimeout(context.Background(), 2*time.Second)
			defer cancelFunc()
			if trace != nil {
				_ = trace.Shutdown(timeout)
			}
			if pusher != nil {
				pusher.Stop(timeout)
			}
		}()
		return nil
	}
}

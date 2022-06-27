package uci_messaging_server

import (
	"context"
	"errors"
	"fmt"
	"github.com/assembla/cony"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/config"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/conyer"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/facade"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/provider"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/scheduler"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/web/messager"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/web/pipeliner"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/web/workflower"
	"github.com/cheerego/uci/pkg/http"
	"github.com/cheerego/uci/pkg/http/middleware/uctx"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cheerego/uci/pkg/log/backend"
	"github.com/cheerego/uci/pkg/signal"
	"github.com/cheerego/uci/pkg/uerror"
	"github.com/go-playground/validator"
	"github.com/labstack/echo/v4"
	"go.uber.org/zap"
	"golang.org/x/sync/errgroup"
	"gopkg.in/olahol/melody.v1"
	http2 "net/http"
)

func init() {
	configuration, err := backend.Configuration()
	if err != nil {
		panic(any(err))
	}
	zap.ReplaceGlobals(configuration)
}

type Application struct {
}

func NewApplication() *Application {
	return &Application{}
}

func (a *Application) Start() error {
	err := a.register()
	if err != nil {
		return err
	}
	g, _ := errgroup.WithContext(context.TODO())
	g.Go(a.startHttp)
	g.Go(a.startGrpc)
	g.Go(a.startCron)
	g.Go(a.startCony)
	g.Go(func() error {
		killSignal := signal.KillSignal()
		<-killSignal
		return errors.New("kill signal")
	})
	return g.Wait()
}

func (a *Application) startHttp() error {
	o := http.NewEcho()
	o.Use(uctx.ContextMiddleware)
	o.Debug = true
	o.Validator = NewRequestValidator()

	o.HTTPErrorHandler = uerror.JSONHttpErrorHandler(o)

	o.GET("/", func(ctx echo.Context) error {
		return ctx.String(200, "Hello World, UCI MESSAGING SERVER")
	})

	workflower.Route(o)
	messager.Route(o)
	pipeliner.Route(o)

	WS(o)
	return o.Start(fmt.Sprintf(":%d", config.Configs.HttpPort))
}

type RequestValidator struct {
	validator *validator.Validate
}

func NewRequestValidator() *RequestValidator {
	return &RequestValidator{validator: validator.New()}
}

func (cv *RequestValidator) Validate(i interface{}) error {
	if err := cv.validator.Struct(i); err != nil {
		// Optionally, you could return the error to give each route more control over the status code
		return echo.NewHTTPError(http2.StatusBadRequest, err.Error())
	}
	return nil
}

func (a *Application) startGrpc() error {
	return nil
}

func (a *Application) startCron() error {
	s, err := scheduler.NewScheduler()
	if err != nil {
		return err
	}
	go func() {
		killSignal := signal.KillSignal()
		<-killSignal
		s.Scheduler.Stop()
	}()
	s.Start()
	return nil
}
func (a *Application) startCony() error {
	cli := conyer.New(cony.URL(config.Configs.RabbitAddrUrl))
	for cli.Loop() {
		select {
		case err := <-cli.Errors():
			log.L().Error("cony client err", zap.Error(err))
		}
	}
	return nil
}

func (a *Application) register() error {
	if err := config.Register(); err != nil {
		return err
	}

	if err := provider.Register(); err != nil {
		return err
	}

	if err := service.Register(); err != nil {
		return err
	}

	if err := facade.Register(); err != nil {
		return err
	}

	return nil
}

func WS(r *echo.Echo) {
	m := melody.New()

	r.GET("/uci/ws", func(c echo.Context) error {
		return m.HandleRequest(c.Response().Writer, c.Request())
	})

	m.HandlePong(func(session *melody.Session) {

	})
	m.HandleConnect(func(session *melody.Session) {

	})
	m.HandleClose(func(session *melody.Session, i int, s string) error {
		return nil
	})
	m.HandleDisconnect(func(session *melody.Session) {

	})
	m.HandleSentMessage(func(session *melody.Session, bytes []byte) {

	})
	m.HandleMessage(func(s *melody.Session, msg []byte) {
		m.Broadcast(msg)
	})
}

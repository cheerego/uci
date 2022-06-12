package uci_messaging_server

import (
	"context"
	"errors"
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/config"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/repository"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/storage"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/web"
	"github.com/cheerego/uci/pkg/http"
	"github.com/cheerego/uci/pkg/http/middleware/uctx"
	"github.com/cheerego/uci/pkg/log/backend"
	"github.com/cheerego/uci/pkg/signal"
	"github.com/cheerego/uci/pkg/uerror"
	"github.com/go-co-op/gocron"
	"go.uber.org/zap"
	"golang.org/x/sync/errgroup"
	"time"
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

func (a *Application) register() error {
	if err := config.Register(); err != nil {
		return err
	}

	if err := storage.Register(); err != nil {
		return err
	}

	if err := repository.Register(); err != nil {
		return err
	}
	if err := service.Register(); err != nil {
		return err
	}

	return nil
}

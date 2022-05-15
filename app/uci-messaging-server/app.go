package uci_messaging_server

import (
	"context"
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/config"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/storage"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/web"
	"github.com/cheerego/uci/pkg/http"
	_ "github.com/cheerego/uci/pkg/log/backend"
	"github.com/go-co-op/gocron"
	"golang.org/x/sync/errgroup"
	"time"
)

type Application struct {
}

func NewApplication() *Application {
	return &Application{}
}

func (a *Application) Start() error {
	g, _ := errgroup.WithContext(context.TODO())
	g.Go(a.startHttp)
	g.Go(a.startGrpc)
	g.Go(a.startCron)
	return g.Wait()
}

func (a *Application) startHttp() error {
	echo := http.NewEcho()
	web.Route(echo)
	storage.FromContext(context.TODO())
	return echo.Start(fmt.Sprintf(":%d", config.Configs.HttpPort))
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
	s.Stop()
	return nil
}

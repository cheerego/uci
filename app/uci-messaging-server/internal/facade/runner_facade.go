package facade

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/lock"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/runner"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/provider"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"net"
	"time"
)

type RunnerFacade struct {
}

func NewRunnerFacade() *RunnerFacade {
	return &RunnerFacade{}
}
func (f *RunnerFacade) UpdateStatus(ctx context.Context, run *runner.Runner, status runner.Status) error {
	_, err := service.Services.RunnerService.UpdateStatus(ctx, run, status)
	if err != nil {
		return err
	}
	switch status {
	case runner.Running:
		return f.SetEXDiscovery(ctx, run)
	case runner.NotRunning:
		return f.DelDiscovery(ctx, run)
	case runner.FakeRunning:
		return f.DelDiscovery(ctx, run)
	}
	return nil
}

func (f *RunnerFacade) SetEXDiscovery(ctx context.Context, run *runner.Runner) error {
	ips := getClientIps()
	_, err := provider.Redis().SetEX(ctx, lock.GetRunnerDiscoveryKey(run.ID), ips[0], 100*time.Second).Result()
	return err
}

func (f *RunnerFacade) DelDiscovery(ctx context.Context, run *runner.Runner) error {
	_, err := provider.Redis().Del(ctx, lock.GetRunnerDiscoveryKey(run.ID)).Result()
	return err
}

func (f *RunnerFacade) GetDiscoveryIpAndTTL(ctx context.Context, run *runner.Runner) error {
	ips := getClientIps()
	_, err := provider.Redis().SetEX(ctx, lock.GetRunnerDiscoveryKey(run.ID), ips[0], 100*time.Second).Result()
	return err
}

func getClientIps() (ips []string) {

	addrs, err := net.InterfaceAddrs()
	if err != nil {
		return ips
	}

	for _, addr := range addrs {
		ipNet, ok := addr.(*net.IPNet)
		if ok && !ipNet.IP.IsLoopback() {
			ips = append(ips, ipNet.IP.String())
		}
	}
	return ips
}

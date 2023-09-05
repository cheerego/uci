package service

import (
	"context"
	"fmt"
	"github.com/cheerego/uci/pkg/dao/model"
	"io"
	"net"
	"net/http"
	"time"
)

type RunnerClientService struct {
	httpClient *http.Client
}

func NewRunnerClientService() *RunnerClientService {
	client := &http.Client{
		Transport: &http.Transport{
			Dial: (&net.Dialer{
				//	建立握手的超时事件
				Timeout:   10 * time.Second,
				KeepAlive: 100 * time.Second,
			}).Dial,
			//TLSHandshakeTimeout:   10 * time.Second,
			//ResponseHeaderTimeout: 10 * time.Second,
			//ExpectContinueTimeout: 1 * time.Second,
		},
		Timeout: 0,
	}
	return &RunnerClientService{
		httpClient: client,
	}
}

func (r *RunnerClientService) FetchRunnerConfig(ctx context.Context, runner *model.Runner) (string, error) {
	request, err := http.NewRequest(http.MethodGet, fmt.Sprintf("http://%s:%d", runner.Host, runner.Port), nil)
	if err != nil {
		return "", err
	}
	request.WithContext(ctx)
	response, err := r.httpClient.Do(request)
	if err != nil {
		return "", err
	}
	defer response.Body.Close()

	body, err := io.ReadAll(response.Body)
	if err != nil {
		return "", err
	}
	return string(body), err
}

func (r *RunnerClientService) DockerPull(ctx context.Context, runner *model.Runner, image string) {

}

func (r *RunnerClientService) DockerRun(ctx context.Context, runner *model.Runner, image string) {

}

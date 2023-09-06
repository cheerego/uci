package service

import (
	"context"
	"fmt"
	"github.com/cheerego/uci/pkg/dao/model"
	"github.com/cockroachdb/errors"
	"io"
	"io/ioutil"
	"net"
	"net/http"
	"strconv"
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

func (r *RunnerClientService) Exec(ctx context.Context, taskName string, ip string, port int, shell string, timeoutSecond int) (string, error) {

	client := http.DefaultClient

	req, _ := http.NewRequest("GET", fmt.Sprintf("http://%s:%d/runner/exec", ip, port), nil)

	q := req.URL.Query()
	q.Add("script", shell)
	q.Add("timeout", strconv.Itoa(timeoutSecond))
	req.URL.RawQuery = q.Encode()
	do, err := client.Do(req)
	if err != nil {
		return "", err
	}
	defer do.Body.Close()

	all, err := ioutil.ReadAll(do.Body)
	if err != nil {
		return "", err
	}

	var returnErr error = nil
	if do.StatusCode != 200 {
		returnErr = errors.New("dispatch uci-uci-runner status code != 200")
	}
	return string(all), returnErr
}

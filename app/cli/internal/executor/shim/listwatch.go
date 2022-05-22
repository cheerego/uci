package shim

import (
	"bufio"
	"context"
	"github.com/labstack/echo/v4"
	"github.com/pkg/errors"
	"go.uber.org/zap"
	"io"
	"net/http"
	"time"
)

type ListWatch struct {
	BaseShimer
	client *http.Client
}

func NewListWatch() *ListWatch {
	client := &http.Client{
		Transport: http.DefaultTransport,
		Timeout:   100 * time.Second,
	}
	return &ListWatch{
		client:     client,
		BaseShimer: BaseShimer{},
	}
}

var _ Shimer = (*ListWatch)(nil)

func (l *ListWatch) StartListener(ctx context.Context) error {
	for {
		zap.S().Info("list watch start ")
		rid, err := l.Watching(ctx)
		zap.S().Info("list watch end ")
		if err != nil {
			zap.S().Infof("%s list watch err, %v", rid, err)
			time.Sleep(2 * time.Second)
		}
	}
}

func (l *ListWatch) Watching(ctx context.Context) (string, error) {
	url := "http://messaging.uci.127.0.0.1.nip.io/api/v1/message/1/subscribe?watch=true"
	r, err := http.NewRequest(http.MethodGet, url, nil)
	if err != nil {
		return "", errors.Wrapf(err, "list watch new http request err, url: %s", url)
	}
	r.WithContext(ctx)
	resp, err := l.client.Do(r)
	if err != nil {
		return "", errors.Wrapf(err, "list watch do http request err, url: %s", url)
	}
	defer resp.Body.Close()

	rid := resp.Header.Get(echo.HeaderXRequestID)
	if rid != "" {
		zap.L().Info("list and watch success", zap.String("requestId", rid))
	}

	defer func() {
		if rid != "" {
			zap.L().Info("list and watch end", zap.String("requestId", rid))
		} else {
			zap.L().Info("list and watch end")
		}
	}()

	reader := bufio.NewReader(resp.Body)
	for {
		line, err := reader.ReadString('\n')
		if len(line) > 0 {
			zap.L().Info("list watch receive message", zap.String("line", line))
		}
		if err == io.EOF {
			break
		}
		if err != nil {
			return rid, err
		}
	}
	return rid, nil
}

package shim

import (
	"bufio"
	"github.com/labstack/echo/v4"
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

func (l *ListWatch) StartListener() error {
	for {
		zap.S().Info("list watch start ")
		err := l.Watching()
		zap.S().Info("list watch end ")
		if err != nil {
			zap.S().Info("list watch err, %v", err)
			time.Sleep(2 * time.Second)
		}
	}
}

func (l *ListWatch) Watching() error {
	resp, err := l.client.Get("http://messaging.uci.127.0.0.1.nip.io/api/v1/message/1/subscribe?watch=true")
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	rid := resp.Header.Get(echo.HeaderXRequestID)
	if rid != "" {
		zap.L().Info("list and watch success", zap.String("requestId", rid))
	}

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
			return err
		}
	}
	return nil
}

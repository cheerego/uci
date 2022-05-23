package listwatch

import (
	"bufio"
	"context"
	"github.com/cheerego/uci/app/cli/internal/messaging"
	"github.com/cheerego/uci/app/cli/internal/uerror"
	"github.com/labstack/echo/v4"
	"github.com/pkg/errors"
	"go.uber.org/zap"
	"io"
	"net/http"
	"time"
)

type ListWatch struct {
	messagingCh chan string
	client      *http.Client
}

var _ messaging.Shimer = (*ListWatch)(nil)

func NewShimer() *ListWatch {
	client := &http.Client{
		Transport: http.DefaultTransport,
		Timeout:   100 * time.Second,
	}
	return &ListWatch{
		messagingCh: make(chan string),
		client:      client,
	}
}

func (l *ListWatch) Listening(ctx context.Context) error {
	for {
		select {
		case <-ctx.Done():
			zap.L().Info("list watch listening canceled")
			return uerror.ErrContextCanceled.WithStack()
		default:
			zap.S().Info("list watch start ...")
			rid, err := l.Watching(ctx)
			if err != nil {
				zap.S().Infof("%s list watch err, %v", rid, err)
				time.Sleep(2 * time.Second)
			}
		}
	}
}

func (l *ListWatch) Consuming(ctx context.Context) error {

	for {
		select {
		case <-ctx.Done():
			zap.L().Info("list watch consuming canceled")
			return uerror.ErrContextCanceled.WithStack()
		case line, ok := <-l.messagingCh:
			if !ok {
				return errors.New("list watch consuming select chan return no ok")
			}
			zap.L().Info("list watch consuming receive message from chan ", zap.String("line", line))
		}

	}
}

func (l *ListWatch) Watching(ctx context.Context) (string, error) {
	url := "http://messaging.uci.127.0.0.1.nip.io/api/v1/message/1/subscribe?watch=true"
	r, err := http.NewRequestWithContext(ctx, http.MethodGet, url, nil)
	if err != nil {
		return "", errors.Wrapf(err, "list watch new http request err, url: %s", url)
	}
	resp, err := l.client.Do(r)
	if err != nil {
		return "", errors.Wrapf(err, "list watch do http request err, url: %s", url)
	}
	defer resp.Body.Close()

	rid := resp.Header.Get(echo.HeaderXRequestID)
	zap.L().Info("list watch success! 🎉", zap.String("requestId", rid))

	defer func() {
		zap.L().Info("list and watch end", zap.String("requestId", rid))
	}()

	reader := bufio.NewReader(resp.Body)
	for {
		line, err := reader.ReadString('\n')
		if len(line) > 0 {
			zap.L().Info("list watch watching receive message", zap.String("line", line), zap.String("requestId", rid))
			l.messagingCh <- line
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

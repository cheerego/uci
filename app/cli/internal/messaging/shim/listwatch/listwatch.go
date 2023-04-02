package listwatch

import (
	"bufio"
	"context"
	"encoding/json"
	"github.com/cheerego/uci/app/cli/internal/requests"
	"github.com/cheerego/uci/app/cli/internal/uerror"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cheerego/uci/protocol/letter"
	"github.com/cockroachdb/errors"
	"github.com/labstack/echo/v4"
	"go.uber.org/zap"
	"io"
	"io/ioutil"
	"net/http"
	"strings"
	"time"
)

type ListWatch struct {
	messagingCh chan string
	client      *http.Client
}

func (l *ListWatch) Ack(msg string) error {
	var le letter.Letter
	err := json.Unmarshal([]byte(msg), &le)
	if err != nil {
		log.L().Error("json.Unmarshal letterString err", zap.Error(err), zap.String("letterString", msg))
		return err
	}
	err = requests.Ack(le.AckId)
	if err != nil {
		return err
	}
	log.S().Infof("ack ackId %s letter %s", le.AckId, msg)
	return nil
}

func (l *ListWatch) MessageChan() <-chan string {
	return l.messagingCh
}

func NewShimer() *ListWatch {
	client := &http.Client{
		Transport: http.DefaultTransport,
		//Timeout:   100 * time.Second,
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
			log.L().Info("list watch listening canceled")
			return uerror.ErrContextCanceledOrTimeout.WithStack()
		default:
			log.S().Info("list watch start ...")
			rid, err := l.Watching(ctx)
			if err != nil {
				log.S().Infof("%s list watch err, %v", rid, err)
				time.Sleep(2 * time.Second)
			}
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

	if resp.StatusCode != http.StatusOK {
		b, err := ioutil.ReadAll(resp.Body)
		if err != nil {
			return "", errors.Wrapf(err, "read http response body err")
		}
		return "", errors.Newf("http response status code != 200, body is %s", string(b))
	}

	rid := resp.Header.Get(echo.HeaderXRequestID)
	log.L().Info("list watch success! 🎉", zap.String("requestId", rid))

	defer func() {
		log.L().Info("list and watch end", zap.String("requestId", rid))
	}()

	reader := bufio.NewReader(resp.Body)

	for {
		line, err := reader.ReadString('\n')
		if len(line) > 0 {
			log.L().Info("list watch watching receive message", zap.String("line", line), zap.String("requestId", rid))
			line = strings.TrimRight(line, "\n")
			if line != "" {
				l.messagingCh <- line
			}
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

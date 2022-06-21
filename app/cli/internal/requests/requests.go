package requests

import (
	"context"
	"crypto/tls"
	"github.com/cheerego/uci/app/cli/internal/config/host"
	"github.com/cheerego/uci/app/cli/internal/uerror"
	"github.com/cheerego/uci/pkg/log"
	"github.com/go-resty/resty/v2"
	"github.com/pkg/errors"
	"go.uber.org/zap"
	"net/http"
	"strconv"
	"time"
)

var client = resty.
	NewWithClient(&http.Client{
		Transport: http.DefaultTransport,
	}).
	SetTLSClientConfig(&tls.Config{
		InsecureSkipVerify: true,
	}).
	SetRetryCount(3).
	SetRetryWaitTime(2*time.Second).
	SetHeader("Content-Type", "application/json")

func ReportRawlog(ctx context.Context, uuid string, append bool, raw string) error {
	client := resty.New()
	timeout, cancelFunc := context.WithTimeout(ctx, 30*time.Second)
	defer cancelFunc()

	var result = make(map[string]interface{})
	resp, err := client.R().
		SetContext(timeout).
		SetBody(map[string]interface{}{
			"uuid": uuid,
			"raw":  raw,
		}).
		SetResult(result).
		SetQueryParams(map[string]string{
			"append": strconv.FormatBool(append),
		}).
		Post(host.Host() + "/api/v1/pipeliner/report/log/raw")

	if err != nil {
		err := errors.Wrapf(err, "url: %s, body: %v, queryParam: %v, result: %v", resp.Request.URL, resp.Request.Body, resp.Request.QueryParam, result)
		log.L().Error("report raw log err", zap.Error(err))
		return err
	}

	if resp.StatusCode() != 200 {
		err := errors.Wrapf(uerror.ErrHttpResponseCodeNot200, "url: %s, body: %v, queryParam: %v, result: %v", resp.Request.URL, resp.Request.Body, resp.Request.QueryParam, result)
		log.L().Error("report log raw status code != 200", zap.Error(err))
		return err
	}
	return nil
}

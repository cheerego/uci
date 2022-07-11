package requests

import (
	"context"
	"github.com/cheerego/uci/app/cli/internal/config"
	"github.com/cheerego/uci/app/cli/internal/uerror"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cockroachdb/errors"
	"go.uber.org/zap"
	"strconv"
	"time"
)

func ReportRawlog(uuid string, append bool, raw string) error {
	timeout, cancelFunc := context.WithTimeout(context.Background(), 30*time.Second)
	defer cancelFunc()

	serverUrl, err := config.UciServerUrl.Value()
	if err != nil {
		return err
	}

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
		Post(serverUrl + "/api/v1/pipeline/report/log/raw")

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

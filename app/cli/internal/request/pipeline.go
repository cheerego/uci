package request

import (
	"context"
	"github.com/cheerego/uci/app/cli/internal/config"
	"github.com/cheerego/uci/app/cli/internal/uerror"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cockroachdb/errors"
	"go.uber.org/zap"
	"time"
)

func ReportPipelineStatus(uuid string, status string, failedCause string) error {
	timeout, cancelFunc := context.WithTimeout(context.Background(), 30*time.Second)
	defer cancelFunc()

	var result = make(map[string]interface{})
	resp, err := client.R().
		SetContext(timeout).
		SetBody(map[string]interface{}{
			"uuid":        uuid,
			"status":      status,
			"timestamp":   time.Now(),
			"failedCause": failedCause,
		}).
		SetResult(result).
		Post(config.Host() + "/api/v1/pipeline/report/status")

	if err != nil {
		err := errors.Wrapf(err, "url: %s, body: %v, queryParam: %v, result: %v", resp.Request.URL, resp.Request.Body, resp.Request.QueryParam, result)
		log.L().Error("report pipeline status err", zap.Error(err))
		return err
	}

	if resp.StatusCode() != 200 {
		err := errors.Wrapf(uerror.ErrHttpResponseCodeNot200, "url: %s, body: %v, queryParam: %v, statusCode: %v result: %v", resp.Request.URL, resp.Request.Body, resp.Request.QueryParam, resp.StatusCode(), result)
		log.L().Error("report pipeline status, status code != 200", zap.Error(err))
		return err
	}
	return nil
}

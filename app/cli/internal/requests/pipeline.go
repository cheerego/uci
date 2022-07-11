package requests

import (
	"context"
	"github.com/cheerego/uci/app/cli/internal/config"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cheerego/uci/protocol/letter"
	"time"
)

func PipelineUncompletedStatus(payload *letter.StartPipelinePayload, status string) error {
	timeout, cancelFunc := context.WithTimeout(context.Background(), 30*time.Second)
	defer cancelFunc()

	body := map[string]interface{}{
		"uuid":      payload.Uuid,
		"status":    status,
		"timestamp": time.Now(),
	}
	serverUrl, err := config.UciServerUrl.Value()
	if err != nil {
		return err
	}

	r := client.
		R().
		SetContext(timeout).
		SetBody(body)
	return log.Tee("request uncompleted status", doPost(r, serverUrl+"/api/v1/pipeline/report/status"))
}

func PipelineFinishedStatus(payload *letter.StartPipelinePayload, err error) error {

	timeout, cancelFunc := context.WithTimeout(context.Background(), 30*time.Second)
	defer cancelFunc()
	var status string
	var failedCause string
	if err != nil {
		status = "BUILD_FAILED"
		failedCause = err.Error()
	} else {
		status = "BUILD_SUCCEED"
	}
	body := map[string]interface{}{
		"uuid":        payload.Uuid,
		"status":      status,
		"timestamp":   time.Now(),
		"failedCause": failedCause,
	}

	r := client.R().SetContext(timeout).SetBody(body)

	serverUrl, err := config.UciServerUrl.Value()
	if err != nil {
		return err
	}
	return log.Tee("request finished status", doPost(r, serverUrl+"/api/v1/pipeline/report/status"))

}

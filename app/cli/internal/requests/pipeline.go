package requests

import (
	"context"
	"github.com/cheerego/uci/app/cli/internal/config"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cheerego/uci/protocol/letter"
	"time"
)

func PipelineBuildStatus(payload *letter.StartPipelinePayload, status string) error {
	timeout, cancelFunc := context.WithTimeout(context.Background(), 30*time.Second)
	defer cancelFunc()

	body := map[string]interface{}{
		"uuid": payload.Uuid,
	}
	serverUrl, err := config.UciServerUrl.Value()
	if err != nil {
		return err
	}

	r := client.
		R().
		SetContext(timeout).
		SetBody(body)
	return log.Tee("request build running", doPost(r, serverUrl+"/api/v1/pipeline/report/status/"+status))
}

func PipelineBuildFailed(payload *letter.StartPipelinePayload, err error) error {
	timeout, cancelFunc := context.WithTimeout(context.Background(), 30*time.Second)
	defer cancelFunc()
	body := map[string]interface{}{
		"uuid":        payload.Uuid,
		"failedCause": err.Error(),
	}

	r := client.R().SetContext(timeout).SetBody(body)

	serverUrl, err := config.UciServerUrl.Value()
	if err != nil {
		return err
	}
	return log.Tee("request build failed", doPost(r, serverUrl+"/api/v1/pipeline/report/status/BUILD_FAILED"))
}

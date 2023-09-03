package requests

import (
	"context"
	"github.com/cheerego/uci/app/cli/internal/config"
	"strconv"
	"time"
)

func PipelineRawlog(uuid string, append bool, raw string) error {
	timeout, cancelFunc := context.WithTimeout(context.Background(), 30*time.Second)
	defer cancelFunc()

	serverUrl, err := config.UciServerUrl.Value()
	if err != nil {
		return err
	}
	r := client.R().
		SetContext(timeout).
		SetBody(map[string]interface{}{
			"uuid": uuid,
			"raw":  raw,
		}).
		SetQueryParams(map[string]string{
			"append": strconv.FormatBool(append),
		})
	return doPost(r, serverUrl+"/api/v1/pipeline/report/log/raw")
}

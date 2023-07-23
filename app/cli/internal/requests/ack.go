package requests

import (
	"context"
	"github.com/cheerego/uci/app/cli/internal/config"
	"github.com/cheerego/uci/pkg/z"
	"time"
)

func Ack(requestId string) error {
	timeout, cancelFunc := context.WithTimeout(context.Background(), 30*time.Second)
	defer cancelFunc()

	serverUrl, err := config.UciServerUrl.Value()
	if err != nil {
		return err
	}

	r := client.
		R().
		SetContext(timeout)
	return z.Tee("request ack err", doPost(r, serverUrl+"/api/v1/message/ack/"+requestId))
}

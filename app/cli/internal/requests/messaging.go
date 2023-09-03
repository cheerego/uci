package requests

import (
	"context"
	"github.com/cheerego/uci/app/cli/internal/config"
	"github.com/cheerego/uci/pkg/log"
	"time"
)

func MessagingUnsubscribe(uuid string) error {
	timeout, cancelFunc := context.WithTimeout(context.Background(), 30*time.Second)
	defer cancelFunc()

	serverUrl, err := config.UciServerUrl.Value()
	if err != nil {
		return err
	}

	r := client.
		R().
		SetContext(timeout)

	return log.Tee("request build running", doPost(r, serverUrl+"/api/v1/message/1/unsubscribe"))
}

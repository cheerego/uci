package console

import (
	"github.com/cheerego/uci/pkg/log"
	"go.uber.org/zap"
)

func Configuration(logPath string) (*zap.Logger, error) {
	backend, err := log.Console(log.DefaultLogLevel(), logPath)
	if err != nil {
		return nil, err
	}
	return log.WrapperSentry(backend)
}

package console

import (
	"github.com/cheerego/uci/pkg/z"
	"go.uber.org/zap"
)

func Configuration(logPath string) (*zap.Logger, error) {
	backend, err := z.Console(z.DefaultLogLevel(), logPath)
	if err != nil {
		return nil, err
	}
	return z.WrapperSentry(backend)
}

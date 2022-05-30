package backend

import (
	"github.com/cheerego/uci/pkg/log"
	"go.uber.org/zap"
)

func Configuration() (*zap.Logger, error) {
	backend, err := log.Backend(log.DefaultLogLevel())
	if err != nil {
		return nil, err
	}
	return log.WrapperSentry(backend)
}

//func init() {
//	logger, err := loggerInit()
//	if err != nil {
//		panic(any(err))
//	}
//	zap.ReplaceGlobals(logger)
//}

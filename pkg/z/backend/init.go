package backend

import (
	"github.com/cheerego/uci/pkg/z"
	"go.uber.org/zap"
)

func Configuration() (*zap.Logger, error) {
	backend, err := z.Backend(z.DefaultLogLevel())
	if err != nil {
		return nil, err
	}
	return z.WrapperSentry(backend)
}

//func init() {
//	logger, err := loggerInit()
//	if err != nil {
//		panic(any(err))
//	}
//	zap.ReplaceGlobals(logger)
//}

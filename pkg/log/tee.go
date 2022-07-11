package log

import (
	"go.uber.org/zap"
	"go.uber.org/zap/zapcore"
)

func Tee(msg string, err error, fields ...zapcore.Field) error {
	if err != nil {
		fields = append(fields, zap.Error(err))
		L().Error(msg, fields...)
	}
	return err
}

package log

import (
	"context"
	"github.com/TheZeroSlave/zapsentry"
	"github.com/getsentry/sentry-go"
	"go.uber.org/zap"
	"go.uber.org/zap/zapcore"
	"log"
	"os"
)

var (
	logger *zap.Logger
)

var logLevelMap map[string]zapcore.Level = map[string]zapcore.Level{
	"debug":  zapcore.DebugLevel,
	"info":   zapcore.InfoLevel,
	"warn":   zapcore.WarnLevel,
	"error":  zapcore.ErrorLevel,
	"dpanic": zapcore.DPanicLevel,
	"panic":  zapcore.PanicLevel,
	"fatal":  zapcore.FatalLevel,
}

const XRequestId = "X-Request-ID"

func init() {
	logLevel := os.Getenv("LOG_LEVEL")
	if logLevel == "" {
		logLevel = "info"
	}
	var err error
	var config = zap.NewProductionConfig()
	config.EncoderConfig.EncodeTime = zapcore.TimeEncoderOfLayout("2006-01-02 15:04:05.9999")
	config.EncoderConfig.TimeKey = "time"
	config.Level = zap.NewAtomicLevelAt(logLevelMap[logLevel])
	opts := []zap.Option{
		zap.AddCaller(),
		zap.AddCallerSkip(1),
		zap.AddStacktrace(zapcore.ErrorLevel),
	}
	logger, err = config.Build(opts...)
	if err != nil {
		log.Fatalln("[ZAP] zap init failure")
	}

	sentryDsn := os.Getenv("SENTRY_DSN")
	if sentryDsn != "" {
		client, err := sentry.NewClient(sentry.ClientOptions{
			Dsn: sentryDsn,
		})
		if err != nil {
			logger.Fatal("[ZAP] SENTRY_DSN env error", zap.Error(err))
		}
		logger = modifyToSentryLogger(logger, client)
	}

}

func modifyToSentryLogger(logger *zap.Logger, client *sentry.Client) *zap.Logger {
	if client == nil {
		return logger
	}
	cfg := zapsentry.Configuration{
		Level: zap.ErrorLevel,
	}
	core, err := zapsentry.NewCore(cfg, zapsentry.NewSentryClientFromClient(client))
	if err != nil {
		logger.Error("FailedWithStatusCode to init zapsentry", zap.Error(err))
	}
	return zapsentry.AttachCoreToLogger(core, logger)
}

func Debug(msg string, fields ...zapcore.Field) {
	logger.Debug(msg, fields...)
}

func Info(msg string, fields ...zapcore.Field) {
	logger.Info(msg, fields...)
}

func Warn(msg string, fields ...zapcore.Field) {
	logger.Warn(msg, fields...)
}

func Error(msg string, fields ...zapcore.Field) {
	logger.Error(msg, fields...)
}

func Fatal(msg string, fields ...zapcore.Field) {
	logger.Fatal(msg, fields...)
}

func Panic(msg string, fields ...zapcore.Field) {
	logger.Panic(msg, fields...)
}

func DPanic(msg string, fields ...zapcore.Field) {
	logger.DPanic(msg, fields...)
}

func With(fields ...zapcore.Field) *zap.Logger {
	return logger.With(fields...)
}

func Named(s string) *zap.Logger {
	return logger.Named(s)
}

func Instance() *zap.Logger {
	return logger
}

func FromContext(ctx context.Context) *zap.Logger {
	return logger.With(zap.Any(XRequestId, ctx.Value(XRequestId)))
}

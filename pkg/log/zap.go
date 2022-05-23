package log

import (
	"github.com/TheZeroSlave/zapsentry"
	"github.com/getsentry/sentry-go"
	"go.uber.org/zap"
	"go.uber.org/zap/zapcore"
	"gopkg.in/natefinch/lumberjack.v2"
	"os"
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

func modifyToSentryLogger(logger *zap.Logger, client *sentry.Client) (*zap.Logger, error) {
	if client == nil {
		return logger, nil
	}
	cfg := zapsentry.Configuration{
		Level: zap.ErrorLevel,
	}
	core, err := zapsentry.NewCore(cfg, zapsentry.NewSentryClientFromClient(client))
	if err != nil {
		return nil, err
	}
	return zapsentry.AttachCoreToLogger(core, logger), nil
}

func Cli(logLevel string, logPath string) (*zap.Logger, error) {
	var encoderConfig = zap.NewDevelopmentEncoderConfig()
	encoderConfig.EncodeTime = zapcore.TimeEncoderOfLayout("2006-01-02 15:04:05.99")
	encoderConfig.EncodeLevel = zapcore.CapitalColorLevelEncoder
	encoderConfig.TimeKey = "time"
	opts := []zap.Option{
		zap.AddCaller(),
		zap.AddStacktrace(zapcore.ErrorLevel),
	}

	fileWriteSyncer := zapcore.AddSync(&lumberjack.Logger{
		Filename:   logPath,
		MaxSize:    500, // megabytes
		MaxBackups: 3,
		MaxAge:     15,   //days
		Compress:   true, // disabled by default
	})

	//config.EncoderConfig,
	core := zapcore.NewCore(zapcore.NewConsoleEncoder(encoderConfig), zapcore.NewMultiWriteSyncer(fileWriteSyncer, zapcore.AddSync(os.Stdout)), logLevelMap[logLevel])
	return zap.New(core, opts...), nil

}
func DefaultLogLevel() string {
	logLevel := os.Getenv("LOG_LEVEL")
	if logLevel == "" {
		logLevel = "info"
	}
	return logLevel
}

func Backend(logLevel string) (*zap.Logger, error) {
	var config = zap.NewProductionConfig()
	config.EncoderConfig.EncodeTime = zapcore.TimeEncoderOfLayout("2006-01-02 15:04:05.9999")
	config.EncoderConfig.TimeKey = "time"
	config.Level = zap.NewAtomicLevelAt(logLevelMap[logLevel])
	opts := []zap.Option{
		zap.AddCaller(),
		zap.AddStacktrace(zapcore.ErrorLevel),
	}
	return config.Build(opts...)
}

func WrapperSentry(l *zap.Logger) (*zap.Logger, error) {
	sentryDsn := os.Getenv("SENTRY_DSN")
	if sentryDsn == "" {
		return l, nil
	}
	client, err := sentry.NewClient(sentry.ClientOptions{
		Dsn: sentryDsn,
	})
	if err != nil {
		return nil, err
	}
	return modifyToSentryLogger(l, client)
}

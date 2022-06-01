package index

import (
	"context"
	"github.com/cheerego/uci/pkg/log"
	"github.com/labstack/echo/v4"
	"go.opentelemetry.io/otel"
	"go.uber.org/zap"
)

func Index(ctx echo.Context) error {
	log.L().Info("123123")
	log.L().ErrorContext(ctx.Request().Context(), "123123", zap.Int("int", 123))
	c, span := otel.Tracer("").Start(ctx.Request().Context(), "start")
	defer span.End()
	asdf(c)

	return ctx.String(200, "Hello World, UCI MESSAGING SERVER")
}

func asdf(ctx context.Context) {
	_, span := otel.Tracer("index.index").Start(ctx, "asd")
	defer span.End()

}

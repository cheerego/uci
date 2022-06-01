package index

import (
	"github.com/cheerego/uci/pkg/log"
	"github.com/labstack/echo/v4"
	"go.opentelemetry.io/otel/trace"
	"go.uber.org/zap"
	trace2 "golang.org/x/net/trace"
)

func Index(ctx echo.Context) error {
	log.TL().ErrorContext(ctx.Request().Context(), "123123", zap.Int("int", 123))
	//_, span := otel.Tracer("index.index").Start(ctx.Request().Context(), "start")
	//defer span.End()
	trace

	return ctx.String(200, "Hello World, UCI MESSAGING SERVER")
}

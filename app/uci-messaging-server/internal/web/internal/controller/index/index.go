package index

import (
	"github.com/labstack/echo/v4"
)

func Index(ctx echo.Context) error {
	//_, span := otel.Tracer("index.index").Start(ctx.Request().Context(), "start")
	//defer span.End()
	return ctx.String(200, "Hello World, UCI MESSAGING SERVER")
}

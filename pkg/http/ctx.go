package http

import (
	"context"
	"github.com/labstack/echo/v4"
	uuid "github.com/satori/go.uuid"
)

func WithRequestId(ctx context.Context) context.Context {
	if _, ok := ctx.Value(echo.HeaderXRequestID).(string); ok {
		return ctx
	}
	return context.WithValue(ctx, echo.HeaderXRequestID, uuid.NewV4().String())
}

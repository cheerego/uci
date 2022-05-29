package web

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/web/internal/controller/index"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/web/internal/controller/messging"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/web/internal/controller/pipeline/report"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/web/internal/controller/workflow"
	"github.com/go-playground/validator"
	"github.com/labstack/echo/v4"
	"net/http"
)

type RequestValidator struct {
	validator *validator.Validate
}

func NewRequestValidator() *RequestValidator {
	return &RequestValidator{validator: validator.New()}
}

func (cv *RequestValidator) Validate(i interface{}) error {
	if err := cv.validator.Struct(i); err != nil {
		// Optionally, you could return the error to give each route more control over the status code
		return echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}
	return nil
}

func Route(r *echo.Echo) {
	r.Validator = NewRequestValidator()
	r.GET("/", index.Index)
	v1 := r.Group("/api/v1")
	{
		v1.GET("/message/:name/subscribe", messging.Subscribe)
		v1.GET("/message/subscribers", messging.Subscribers)
	}
	{
		// inner
		v1.POST("/inner/workflow/:id/trigger", workflow.Trigger)
	}
	{
		v1.POST("/pipeline/report/log/raw", report.Raw)
	}

}

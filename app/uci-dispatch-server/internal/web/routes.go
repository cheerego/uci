package web

import (
	"github.com/cheerego/uci/app/uci-dispatch-server/internal/web/controller/index"
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
	_ = r.Group("/api/v1")
	{
	}

}

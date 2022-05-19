package ectx

import "github.com/labstack/echo/v4"

type Result struct {
	Code       string      `json:"code"`
	Message    string      `json:"message"`
	Data       interface{} `json:"data,omitempty"`
	XRequestId string      `json:"XRequestId,omitempty"`
}

func NewResult(code string, message string, data interface{}, XRequestId string) *Result {
	return &Result{Code: code, Message: message, Data: data, XRequestId: XRequestId}
}

type Context struct {
	echo.Context
}

func ContextMiddleware(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {
		cc := &Context{c}
		return next(cc)
	}
}

func (c *Context) Success() error {

	return c.JSON(200, NewResult("SUCCESS", "", nil, c.Request().Header.Get(echo.HeaderXRequestID)))
}

func (c *Context) Data(data any) error {
	return c.JSON(200, NewResult("SUCCESS", "", data, c.Request().Header.Get(echo.HeaderXRequestID)))
}

func FromContext(c echo.Context) *Context {
	return c.(*Context)
}

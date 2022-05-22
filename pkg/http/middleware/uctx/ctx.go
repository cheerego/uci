package uctx

import "github.com/labstack/echo/v4"

type Result struct {
	Code      string      `json:"code"`
	Message   string      `json:"message"`
	Data      interface{} `json:"data,omitempty"`
	RequestId string      `json:"RequestId,omitempty"`
}

func NewResult(code string, message string, data interface{}, requestId string) *Result {
	return &Result{Code: code, Message: message, Data: data, RequestId: requestId}
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
	rid := c.Request().Header.Get(echo.HeaderXRequestID)
	return c.JSON(200, NewResult("SUCCESS", "SUCCESS", nil, rid))
}

func (c *Context) Data(data any) error {
	rid := c.Request().Header.Get(echo.HeaderXRequestID)
	return c.JSON(200, NewResult("SUCCESS", "SUCCESS", data, rid))
}

func FromContext(c echo.Context) *Context {
	return c.(*Context)
}

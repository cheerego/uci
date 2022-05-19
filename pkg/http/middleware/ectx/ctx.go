package ectx

import "github.com/labstack/echo/v4"

type Result struct {
	Code    int32       `json:"code"`
	Message string      `json:"message"`
	Data    interface{} `json:"data,omitempty"`
}

func NewResult(code int32, message string, data interface{}) *Result {
	return &Result{Code: code, Message: message, Data: data}
}

type Context struct {
	echo.Context
}

func (c *Context) Success() error {
	return c.JSON(200, NewResult(0, "success", nil))
}

func ContextMiddleware(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {
		cc := &Context{c}
		return next(cc)
	}
}

func FromContext(c echo.Context) *Context {
	return c.(*Context)
}

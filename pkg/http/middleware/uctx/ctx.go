package uctx

import (
	"github.com/labstack/echo/v4"
	"strconv"
)

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
func (c *Context) ParamInt(name string) (int, error) {
	param := c.Param(name)
	return strconv.Atoi(param)
}

func (c *Context) ParamUint32(name string) (uint32, error) {
	param := c.Param(name)
	atoi, err := strconv.Atoi(param)
	if err != nil {
		return 0, err
	}
	return uint32(atoi), nil
}

func (c *Context) Data(data any) error {
	rid := c.Request().Header.Get(echo.HeaderXRequestID)
	return c.JSON(200, NewResult("SUCCESS", "SUCCESS", data, rid))
}

func FromContext(c echo.Context) *Context {
	return c.(*Context)
}

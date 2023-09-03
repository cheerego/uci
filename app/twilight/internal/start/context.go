package start

import (
	"github.com/labstack/echo/v4"
)

type StartContext struct {
	echo.Context
	Event        EventType
	WithRepo     bool
	StartRequest *StartRequest
}

type StartRequest struct {
	GitUsername   string
	GitPassword   string
	GitHttpUrl    string
	GitCiFilePath string

	CiFileContent string

	Event EventType
}

func WithContext(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {
		req := &StartRequest{}
		err := c.Bind(req)
		if err != nil {
			return nil
		}
		return next(&StartContext{Context: c, StartRequest: req})
	}
}

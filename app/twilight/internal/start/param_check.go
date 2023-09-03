package start

import (
	"github.com/labstack/echo/v4"
)

type StartRequest struct {
	GitUsername   string
	GitPassword   string
	GitHttpUrl    string
	GitCiFilePath string

	CiFileContent string
}

func ParamCheck(c echo.Context) error {
	req := &StartRequest{}
	err := c.Bind(req)
	if err != nil {
		return nil
	}

	return nil
}

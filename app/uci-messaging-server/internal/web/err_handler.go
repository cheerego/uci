package web

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/uerror"
	"github.com/cockroachdb/errors"
	"github.com/labstack/echo/v4"
	"net/http"
)

func JSONHttpErrorHandler(e *echo.Echo) func(err error, c echo.Context) {
	return func(err error, c echo.Context) {
		if c.Response().Committed {
			return
		}

		var httpCode int
		var message string
		var code string = http.StatusText(http.StatusInternalServerError)
		switch err.(type) {
		case *echo.HTTPError:
			httpCode = http.StatusInternalServerError
			message = http.StatusText(http.StatusInternalServerError)
		case *uerror.UError:
			u := err.(*uerror.UError)
			if u.HttpCode == 0 {
				httpCode = u.HttpCode
				message = u.Message
			}

		}

		var resp echo.Map
		rid := c.Request().Header.Get(echo.HeaderXRequestID)
		if e.Debug {
			resp = echo.Map{"message": message, "XRequestId": rid, "code": code, "error": errors.GetAllDetails(err)}
		} else {
			resp = echo.Map{"message": message, "XRequestId": rid, "code": code}
		}

		// Send response
		if c.Request().Method == http.MethodHead { // Issue #608
			err = c.NoContent(httpCode)
		} else {
			err = c.JSON(httpCode, resp)
		}
		if err != nil {
			e.Logger.Error(err)
		}
	}
}

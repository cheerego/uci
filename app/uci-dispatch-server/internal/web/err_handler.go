package web

import (
	"github.com/cheerego/uci/app/uci-dispatch-server/internal/uerror"
	"github.com/cockroachdb/errors"
	"github.com/labstack/echo/v4"
	"net/http"
)

func JSONHttpErrorHandler(e *echo.Echo) func(err error, c echo.Context) {
	return func(er error, c echo.Context) {
		if c.Response().Committed {
			return
		}

		var httpCode int = http.StatusInternalServerError
		var message string = http.StatusText(http.StatusInternalServerError)
		var code string = http.StatusText(http.StatusInternalServerError)

		cause := errors.Cause(er)

		switch cause.(type) {
		case *echo.HTTPError:
			he := cause.(*echo.HTTPError)
			httpCode = he.Code
			if m, ok := he.Message.(string); ok {
				message = m
			} else {
				message = he.Error()
			}
			code = message
		case *uerror.UError:

			u := cause.(*uerror.UError)
			if u.HttpCode != 0 {
				httpCode = u.HttpCode
				message = u.Message
				code = u.Code
			}
		default:
			httpCode = http.StatusInternalServerError
			message = http.StatusText(httpCode)
			code = message
		}

		var resp echo.Map

		if e.Debug {
			resp = echo.Map{"message": message, "code": code, "error": errors.GetAllDetails(er)}
		} else {
			resp = echo.Map{"message": message, "code": code}
		}

		var rid = c.Request().Header.Get(echo.HeaderXRequestID)
		if rid != "" {
			resp["RequestId"] = rid
		}
		// Send response
		var rerr error
		if c.Request().Method == http.MethodHead { // Issue #608
			rerr = c.NoContent(httpCode)
		} else {
			rerr = c.JSON(httpCode, resp)
		}
		if rerr != nil {
			e.Logger.Error(rerr)
		}
	}
}

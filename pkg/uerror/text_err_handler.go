package uerror

import (
	"fmt"
	"github.com/cockroachdb/errors"
	"github.com/labstack/echo/v4"
	"net/http"
	"strings"
)

func TextHttpErrorHandler(e *echo.Echo) func(err error, c echo.Context) {
	return func(er error, c echo.Context) {
		if c.Response().Committed {
			return
		}

		var httpCode int = http.StatusInternalServerError
		var message string = http.StatusText(http.StatusInternalServerError)
		var code string = http.StatusText(http.StatusInternalServerError)
		httpTargetErr := &echo.HTTPError{}

		var uTargetErr UError
		if errors.As(er, &httpTargetErr) {
			unwrapErr := er
			for {
				if he, ok := unwrapErr.(*echo.HTTPError); ok {
					httpCode = he.Code
					if m, ok := he.Message.(string); ok {
						message = m
					} else {
						message = he.Error()
					}
					code = message
					if httpCode == 404 {
						message = "Route " + message
					}
					break
				} else {
					unwrapErr = errors.Unwrap(er)
				}
			}
		} else if errors.As(er, &uTargetErr) {

			unwrapErr := er
			for {
				if ue, ok := unwrapErr.(*UError); ok {
					if ue.HttpCode != 0 {
						httpCode = ue.HttpCode
					}
					message = ue.Message
					code = ue.Code
					break
				} else {
					unwrapErr = errors.Unwrap(er)
				}
			}
		} else {
			if IsRecordNotFoundErr(er) {
				httpCode = http.StatusNotFound
				message = http.StatusText(httpCode)
				code = http.StatusText(httpCode)
			} else {
				httpCode = http.StatusInternalServerError
				message = er.Error()
				code = http.StatusText(httpCode)
			}
		}

		_ = code
		// Send response
		var rerr error
		if c.Request().Method == http.MethodHead { // Issue #608
			rerr = c.NoContent(httpCode)
		} else {
			rerr = c.String(httpCode, fmt.Sprintf("%s%s", message, strings.Join(errors.GetSafeDetails(er).SafeDetails, "\n")))
		}
		if rerr != nil {
			e.Logger.Error(rerr)
		}
	}
}

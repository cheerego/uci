package uerror

import (
	"fmt"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cockroachdb/errors"
	"github.com/labstack/echo/v4"
	"go.uber.org/zap"
	"net/http"
	"strings"
)

func JSONHttpErrorHandler(e *echo.Echo) func(err error, c echo.Context) {
	return func(er error, c echo.Context) {
		log.L().Error("[HTTP_ERR] "+c.Path(), zap.String("query", c.QueryString()), zap.Error(er))
		if c.Response().Committed {
			return
		}

		httpCode, message, code := convertErrToCode(er)
		var resp echo.Map
		if e.Debug {
			resp = echo.Map{"message": message, "code": code, "detail": errors.GetAllSafeDetails(er), "error": er.Error()}
		} else {
			resp = echo.Map{"message": message, "code": code, "detail": errors.GetAllSafeDetails(er), "error": er.Error()}
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

func convertErrToCode(er error) (httpCode int, message string, code string) {
	httpCode = http.StatusInternalServerError
	message = http.StatusText(http.StatusInternalServerError)
	code = http.StatusText(http.StatusInternalServerError)

	httpTargetErr := &echo.HTTPError{}
	uTargetErr := &UError{}
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

		unwrapErr := errors.UnwrapAll(er)
		if ue, ok := unwrapErr.(*UError); ok {
			if ue.HttpCode != 0 {
				httpCode = ue.HttpCode
			}
			message = ue.Message
			code = ue.Code
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
	return
}

func TextHttpErrorHandler(e *echo.Echo) func(err error, c echo.Context) {
	return func(er error, c echo.Context) {
		log.L().Error("[HTTP_ERR] "+c.Request().URL.Path, zap.String("query", c.QueryString()), zap.Error(er))
		if c.Response().Committed {
			return
		}

		httpCode, message, code := convertErrToCode(er)
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

package uerror

import (
	"fmt"
	"github.com/cockroachdb/errors"
)

type UError struct {
	HttpCode int

	Code string

	Message string
}

func NewUError(httpCode int, code string, message string) *UError {
	return &UError{HttpCode: httpCode, Code: code, Message: message}
}

func (e *UError) Is(err error) bool {
	if err == nil {
		return false
	}
	if e.HttpCode == 404 && IsRecordNotFoundErr(err) {
		return true
	}
	return errors.Is(err, e)
}

func IsRecordNotFoundErr(err error) bool {
	return errors.Cause(err).Error() == "record not found"
}

func (e *UError) Error() string {
	return e.Code
}

func (e *UError) WithMessage(msg string) *UError {
	e.Message = msg
	return e
}

func (e *UError) WithMessagef(format string, args ...interface{}) *UError {
	e.Message = fmt.Sprintf(format, args...)
	return e
}

func (e *UError) WithStack() error {
	return errors.WithStack(e)
}

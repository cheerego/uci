package uerror

import (
	"fmt"
	"github.com/cockroachdb/errors"
)

type UError struct {
	Code string

	Message string
}

func NewUError(code string, message string) *UError {
	return &UError{Code: code, Message: message}
}

func (e *UError) Is(err error) bool {
	if err == nil {
		return false
	}
	return errors.Is(err, e)
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

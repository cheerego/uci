package uerror

import (
	"fmt"
	"github.com/cockroachdb/errors"
)

type UError struct {
	HttpCode int

	Code string

	Message string

	Data any
}

func (e *UError) Is(err error) bool {
	if err == nil {
		return false
	}
	if e.HttpCode == 404 && errors.Cause(err).Error() == "record not found" {
		return true
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

package uerror

import (
	"fmt"
	"github.com/cockroachdb/errors"
)

type UError struct {
	HttpCode int

	ErrorCode string

	Message string
}

func (e *UError) Is(err error) bool {
	if e.HttpCode == 404 && err.Error() == "record not found" {
		return true
	}
	return errors.Is(err, e)
}

func (e *UError) Error() string {
	return e.ErrorCode
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

package eeeee

import (
	"fmt"
	"github.com/cockroachdb/errors"
)

var UnknownError = New("ErrUnknown", "UnknownError", 1).WithMessage("未知错误")

type E struct {
	ErrorCode string
	Code      int
	Message   string
	domain    string
	subCode   string
}

func New(subCode string, domainCode string, code int) *E {
	return &E{ErrorCode: fmt.Sprintf("%s.%s", domainCode, subCode), Code: code, domain: domainCode, subCode: subCode}
}

func NewWithError(domain string, err error, code int) *E {
	return &E{ErrorCode: fmt.Sprintf("%s.%s", domain, err.Error()), Code: code, domain: domain, subCode: err.Error()}
}

//func (e *E) Unwrap() error {
//	return errors.Unwrap(e)
//}

func (e *E) Is(err error) bool {
	//if IsGormRecordNodeFoundError(err) {
	//	return e.subCode == gorm.ErrRecordNotFound.Error()
	//}
	return errors.Is(err, e)
}

func (e *E) Error() string {
	return e.ErrorCode
}

func (e *E) WithMessage(msg string) *E {
	e.Message = msg
	return e
}

func (e *E) WithMessagef(format string, args ...interface{}) *E {
	e.Message = fmt.Sprintf(format, args...)
	return e
}

func (e *E) WithStack() error {
	return errors.WithStack(e)
}

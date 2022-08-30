package uerror

import (
	"fmt"
	"github.com/cockroachdb/errors"
	"testing"
)

var myErr = NewUError(400, "ErrorMyError", "haha myError")

func TestName(t *testing.T) {

	a := myErr.WithMessage("123123")

	fmt.Println(errors.Is(a, myErr))

	fmt.Println(a.Error())

	switch a.(type) {
	case *UError:
		fmt.Println("the type of a is int")
	default:
		fmt.Println("unknown type")
	}

}

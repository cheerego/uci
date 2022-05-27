package uerror

import (
	"fmt"
	"testing"
)

func TestName(t *testing.T) {

	var a error = ErrClientOffline

	switch a.(type) {
	case *UError:
		fmt.Println("the type of a is int")
	default:
		fmt.Println("unknown type")
	}

}

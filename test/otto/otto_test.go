package otto

import (
	"github.com/robertkrimen/otto"
	"testing"
)

func TestOtto(t *testing.T) {

	vm := otto.New()
	vm.Set("env", map[string]string{"username": "123", "password": "123123"})
	value, err := vm.Run("console.log(env.username)")
	t.Log(value, err)
}

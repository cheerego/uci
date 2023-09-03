package jsvm

import "testing"
import "github.com/robertkrimen/otto"

func TestJsVM(t *testing.T) {
	vm := otto.New()
	m := map[string]string{
		"hkn": "123",
	}
	vm.Set("env", m)

	vm.Run(`
	console.log(env.hkn.length)
`)
}

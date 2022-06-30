package ini

import (
	"testing"
)

func TestIni(t *testing.T) {
	ini, err := NewIni("/Users/hekangning/uciapp.conf")
	if err != nil {
		t.Fatal(err)
	}

	t.Log(ini.ReadAll())

}

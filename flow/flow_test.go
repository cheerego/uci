package flow

import (
	"fmt"
	"gopkg.in/yaml.v2"
	"testing"
)

var a = `
t
`

func TestYamlParse(t *testing.T) {
	str := `
name: hello world
on: [ push ]
jobs:
  - name: hello world
    runs-on: ubuntu-latest
    defaults:
      run:
        shell: bash
        working-directory: script
    steps:
      - run: echo hello world
`

	var f Flow
	yaml.Unmarshal([]byte(str), &f)

	fmt.Printf("%+v", f)
}

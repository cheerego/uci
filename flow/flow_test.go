package flow

import (
	"fmt"
	"gopkg.in/yaml.v2"
	"testing"
)

func TestYamlParse(t *testing.T) {
	str := `

name: learn-github-actions
on: [push]
jobs:
  - name: check-bats-version
    steps:
      - uses: actions/checkout@v3
      - run: echo 123
  - name: check-bats-version123
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '14'
      - run: npm install -g bats
      - run: bats -v
`

	var f Flow
	yaml.Unmarshal([]byte(str), &f)

	fmt.Printf("%+v", f)
}

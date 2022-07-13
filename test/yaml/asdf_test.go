package yaml

import (
	"fmt"
	"github.com/mcuadros/go-defaults"
	"gopkg.in/yaml.v2"
	"testing"
)

type Flow struct {
	Name string   `yaml:"name" default:"123"`
	On   []string `yaml:"on"`
	Jobs []Job    `yaml:"jobs"`
}

func (f *Flow) UnmaJobsrshalYAML(unmarshal func(interface{}) error) error {

	if err := unmarshal(f); err != nil {
		defaults.SetDefaults(f)
		return err
	}
	return nil
}

type Job struct {
	Name   string  `yaml:"name"`
	RunsOn *string `yaml:"runs-on,omitempty" default:"123"`
}

func TestDefault(t *testing.T) {

	f := new(Flow)
	defaults.SetDefaults(f)
	fmt.Printf("%#v", f)
}

func TestYamlParse(t *testing.T) {
	str := `name: learn-github-actions
on: [push]
jobs:
  - name: check-bats-version
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '14'
      - run: npm install -g bats
      - run: bats -v
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

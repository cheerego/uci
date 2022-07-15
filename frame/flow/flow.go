package flow

import (
	"github.com/cheerego/uci/frame/status"
	"time"
)

type Flow struct {
	Name string   `yaml:"name,omitempty" json:"name,omitempty"`
	On   []string `yaml:"on,omitempty" json:"on,omitempty"`
	Jobs []*Job   `yaml:"jobs,omitempty" json:"jobs,omitempty"`
}

type Job struct {
	Name     string   `yaml:"name,omitempty" json:"name,omitempty"`
	RunsOn   string   `yaml:"runs-on,omitempty" json:"runsOn,omitempty"`
	If       string   `yaml:"if,omitempty" json:"if,omitempty"`
	Defaults Defaults `yaml:"defaults,omitempty" json:"defaults,omitempty"`
	Steps    []*Step  `yaml:"steps,omitempty" json:"steps,omitempty"`
}

type Defaults struct {
	Run Run `yaml:"run,omitempty" json:"run,omitempty"`
}

type Run struct {
	Shell            string `yaml:"shell,omitempty" json:"shell,omitempty"`
	WorkingDirectory string `yaml:"working-directory,omitempty" json:"workingDirectory,omitempty"`
}

type Step struct {
	Uses   *string            `yaml:"uses,omitempty" json:"uses"`
	With   *map[string]string `yaml:"with,omitempty" json:"with"`
	Run    *string            `yaml:"run,omitempty" json:"run"`
	Result Result             `yaml:"result" json:"result"`
}

type Result struct {
	Status   status.Status `json:"status" yaml:"status"`
	Duration int64         `json:"duration" yaml:"duration"`
	StartAt  *time.Time    `json:"startAt" yaml:"startAt"`
	CloseAt  *time.Time    `json:"closeAt" yaml:"closeAt"`
}

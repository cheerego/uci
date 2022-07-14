package flow

type Flow struct {
	Name string   `yaml:"name,omitempty" json:"name,omitempty"`
	On   []string `yaml:"on,omitempty" json:"on,omitempty"`
	Jobs []Job    `yaml:"jobs,omitempty" json:"jobs,omitempty"`
}
type Job struct {
	Name   string `json:"name,omitempty" yaml:"name,omitempty"`
	RunsOn string `json:"runsOn,omitempty" yaml:"runsOn,omitempty"`
	Steps  []Step `json:"steps,omitempty" yaml:"steps,omitempty"`
}
type Step struct {
	Uses *string           `json:"uses,omitempty" yaml:"uses,omitempty"`
	With map[string]string `json:"with,omitempty" yaml:"with,omitempty"`
	Run  *string           `json:"run,omitempty" yaml:"run,omitempty"`
}

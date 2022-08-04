package flow

import (
	"github.com/cheerego/uci/frame/status"
	"github.com/docker/distribution/reference"
	"github.com/robertkrimen/otto"
	"time"
)

type Flow struct {
	Name string   `yaml:"name,omitempty" json:"name,omitempty"`
	On   []string `yaml:"on,omitempty" json:"on,omitempty"`
	Jobs []*Job   `yaml:"jobs,omitempty" json:"jobs,omitempty"`
}

type Job struct {
	Name     string   `yaml:"name,omitempty" json:"name,omitempty"`
	Docker   Docker   `yaml:"docker,omitempty" json:"docker,omitempty"`
	If       string   `yaml:"if,omitempty" json:"if,omitempty"`
	Defaults Defaults `yaml:"defaults,omitempty" json:"defaults,omitempty"`
	Steps    []*Step  `yaml:"steps,omitempty" json:"steps,omitempty"`
}

type Docker struct {
	Image    string `yaml:"image,omitempty" json:"image,omitempty"`
	Username string `yaml:"username,omitempty" json:"username,omitempty"`
	Password string `yaml:"password,omitempty" json:"password,omitempty"`
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

type Script struct {
	Shell string
	Show  string
}

func (f *Flow) Scripts(envs map[string]string) ([]Script, error) {
	scripts := make([]Script, 0)
	js := otto.New()

	for jobIndex, job := range f.Jobs {
		image := job.Docker.Image
		if image != "" {
			if job.Docker.Username != "" && job.Docker.Password != "" {
				named, err := reference.ParseNormalizedNamed(image)
				if err != nil {
					return scripts, err
				}
				domain := reference.Domain(named)
				if domain != "docker.io" {
					domain = ""
				}
				scripts = append(scripts, Script{
					Shell: "echo docker login ",
					Show:  "docker login -u ",
				})

			}

		}

	}
}

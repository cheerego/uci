package flow

import (
	"fmt"
	"github.com/docker/distribution/reference"
	"path"
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
	Uses *string            `yaml:"uses,omitempty" json:"uses"`
	With *map[string]string `yaml:"with,omitempty" json:"with"`
	Run  *string            `yaml:"run,omitempty" json:"run"`
	If   string             `yaml:"if,omitempty" json:"if,omitempty"`
	//Result Result             `yaml:"result" json:"result"`
}

//type Result struct {
//	Status   status.Status `json:"status" yaml:"status"`
//	Duration int64         `json:"duration" yaml:"duration"`
//	StartAt  *time.Time    `json:"startAt" yaml:"startAt"`
//	CloseAt  *time.Time    `json:"closeAt" yaml:"closeAt"`
//}

type WorkflowScript struct {
	JobScripts []JobScript
}

func NewWorkflowScript() *WorkflowScript {
	return &WorkflowScript{
		JobScripts: make([]JobScript, 0),
	}
}

type JobScript struct {
	Index    string
	Parallel bool
	Script   []Script
}

func NewJobScript(index string, parallel bool) *JobScript {
	return &JobScript{Index: index, Parallel: parallel, Script: make([]Script, 0)}
}

type Script struct {
	Index string
	Shell string
	Show  string
	If    bool
}

func (f *Flow) Scripts(workflowUuid string, envs map[string]string) ([]Script, error) {
	var workflowScript = NewWorkflowScript()

	for jobIndex, job := range f.Jobs {
		jobScript := NewJobScript(path.Join(workflowUuid, fmt.Sprintf("job-%d", jobIndex)), false)
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

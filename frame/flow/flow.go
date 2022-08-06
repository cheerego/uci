package flow

import (
	"fmt"
	"github.com/docker/distribution/reference"
	"path"
	"strings"
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
	Return           string `yaml:"return,omitempty" json:"return,omitempty"`
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
	JobScripts []*JobScript
}

func NewWorkflowScript() *WorkflowScript {
	return &WorkflowScript{
		JobScripts: make([]*JobScript, 0),
	}
}

func (w *WorkflowScript) Append(j *JobScript) {
	w.JobScripts = append(w.JobScripts, j)
}

type JobScript struct {
	Index    string
	Parallel bool
	If       string
	Scripts  []*Script
}

func NewJobScript(index string) *JobScript {
	return &JobScript{Index: index, Parallel: false, Scripts: make([]*Script, 0)}
}

func (j *JobScript) Append(s *Script) {
	j.Scripts = append(j.Scripts, s)
}

type Script struct {
	Index string
	Shell string
	Show  string
}

func NewScript(index string, show string) *Script {
	return &Script{Index: index, Shell: "", Show: show}
}

func (f *Flow) Scripts(workflowUuid string, envs map[string]string) (*WorkflowScript, error) {
	var workflowScript = NewWorkflowScript()

	for jobIndex, job := range f.Jobs {
		jobScript := NewJobScript(path.Join(workflowUuid, fmt.Sprintf("job-%d", jobIndex)))

		// init script
		initScript := NewScript(path.Join(workflowUuid, fmt.Sprintf("job-%d-init", jobIndex)), fmt.Sprintf("job.name = %s init ... docker login -u", job.Name))
		if job.Docker.Image != "" {
			named, err := reference.ParseNormalizedNamed(job.Docker.Image)
			if err != nil {
				return nil, err
			}
			domain := reference.Domain(named)
			if domain != "docker.io" {
				domain = ""
			}

			initScript.Shell = fmt.Sprintf("echo %s | docker login -u %s --password-stdin")
			if job.Docker.Username != "" && job.Docker.Password != "" {
				username := strings.TrimSpace(job.Docker.Username)
				if CanExec(username) {

				}

			} else {

			}
		}
		jobScript.Append(initScript)
		// init script

		workflowScript.Append(jobScript)
	}

	return workflowScript, nil
}

package flow

import (
	"fmt"
	"github.com/docker/distribution/reference"
	"github.com/hoisie/mustache"
	"path"
)

type FlowYaml struct {
	Name   string   `yaml:"name,omitempty" json:"name,omitempty"`
	On     []string `yaml:"on,omitempty" json:"on,omitempty"`
	Docker Docker   `yaml:"docker,omitempty" json:"docker,omitempty"`
	Jobs   []*Job   `yaml:"jobs,omitempty" json:"jobs,omitempty"`
}

type Job struct {
	Name   string `yaml:"name,omitempty" json:"name,omitempty"`
	Docker Docker `yaml:"docker,omitempty" json:"docker,omitempty"`
	If     string `yaml:"if,omitempty" json:"if,omitempty"`
	//Defaults Defaults `yaml:"defaults,omitempty" json:"defaults,omitempty"`
	Steps []*Step `yaml:"steps,omitempty" json:"steps,omitempty"`
}

type Docker struct {
	Image    string `yaml:"image,omitempty" json:"image,omitempty"`
	Username string `yaml:"username,omitempty" json:"username,omitempty"`
	Password string `yaml:"password,omitempty" json:"password,omitempty"`
}

//type Defaults struct {
//	Run Run `yaml:"run,omitempty" json:"run,omitempty"`
//}
//
//type Run struct {
//	Sh               string `yaml:"sh,omitempty" json:"sh,omitempty"`
//	WorkingDirectory string `yaml:"working-directory,omitempty" json:"workingDirectory,omitempty"`
//}

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
	Index string `yaml:"index,omitempty" json:"index,omitempty"`
	Shell string `yaml:"Shell,omitempty" json:"shell,omitempty"`
	Show  string `yaml:"show,omitempty" json:"show,omitempty" json:"show,omitempty"`
	//Defaults Defaults `yaml:"defaults,omitempty" json:"defaults,omitempty" json:"defaults"`
}

func NewScript(index string) *Script {
	return &Script{Index: index, Shell: "", Show: ""}
}

func (f *FlowYaml) Scripts(workflowUuid string, envs map[string]string) (*WorkflowScript, error) {
	var workflowScript = NewWorkflowScript()

	for jobIndex, job := range f.Jobs {
		jobScript := NewJobScript(path.Join(workflowUuid, fmt.Sprintf("job-%d", jobIndex)))

		//if job.Defaults.Run.Sh == "" {
		//	job.Defaults.Run.Sh = "bash"
		//}
		//
		//if job.Defaults.Run.WorkingDirectory == "" {
		//	job.Defaults.Run.WorkingDirectory = "/workspace"
		//}

		// init script
		initScript := NewScript(path.Join(workflowUuid, fmt.Sprintf("job-%d-init", jobIndex)))
		//initScript.Defaults = job.Defaults
		if job.Docker.Image != "" {
			named, err := reference.ParseNormalizedNamed(job.Docker.Image)
			if err != nil {
				return nil, err
			}
			domain := reference.Domain(named)
			if domain != "docker.io" {
				domain = ""
			}

			if job.Docker.Username != "" && job.Docker.Password != "" {
				username := mustache.Render(job.Docker.Username, envs)
				password := mustache.Render(job.Docker.Password, envs)
				initScript.Shell = fmt.Sprintf(`%s && %s`,
					fmt.Sprintf("echo %s | docker login -u %s --password-stdin %s", username, password, domain),
					fmt.Sprintf("docker run -d --name=%s-job-%d-container", workflowUuid, jobIndex),
				)
				initScript.Show = fmt.Sprintf("job %s init ..., echo %s | docker login -u %s --password-stdin %s && docker run -d --name=%s-job-%d-container ",
					job.Name,
					"******",
					username,
					domain,
					workflowUuid,
					jobIndex,
				)
			} else {
				initScript.Shell = fmt.Sprintf("docker pull %s", job.Docker.Image)
			}

		}
		jobScript.Append(initScript)
		// init script

		workflowScript.Append(jobScript)
	}

	return workflowScript, nil
}

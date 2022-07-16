package flow

import (
	"github.com/cheerego/uci/frame/protocol/letter"
	"github.com/docker/docker/client"
	"io"
	"os"
)

type FlowRuntime struct {
	Flow       *Flow
	Payload    *letter.StartPipelinePayload
	Workspace  string
	FlowWriter io.WriteCloser

	Docker *client.Client
}

func NewFlowRuntime(flow *Flow, payload *letter.StartPipelinePayload, workspace string, rawWriter io.WriteCloser) *FlowRuntime {
	return &FlowRuntime{Flow: flow, Payload: payload, Workspace: workspace, FlowWriter: rawWriter}
}

func (r *FlowRuntime) Close() {

}

type JobRuntime struct {
	Runtime   *FlowRuntime
	Job       *Job
	JobWriter io.WriteCloser
	JobReader io.ReadCloser
}

func NewJobRuntime(runtime *FlowRuntime, job *Job) *JobRuntime {
	pipe, writer, _ := os.Pipe()
	return &JobRuntime{
		Runtime:   runtime,
		Job:       job,
		JobWriter: writer,
		JobReader: pipe,
	}
}

type StepRuntime struct {
	Runtime    *FlowRuntime
	JobRuntime *JobRuntime
	Job        *Job
	Step       *Step
}

func NewStepRuntime(runtime *FlowRuntime, jobRuntime *JobRuntime, step *Step) *StepRuntime {
	return &StepRuntime{Runtime: runtime, JobRuntime: jobRuntime, Job: jobRuntime.Job, Step: step}
}

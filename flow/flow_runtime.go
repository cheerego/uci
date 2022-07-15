package flow

import (
	"github.com/cheerego/uci/protocol/letter"
	"io"
)

type Runtime struct {
	Workspace string
	RawWriter io.Writer
	Payload   *letter.StartPipelinePayload
	Flow      *Flow
}

type FlowRuntime struct {
	Runtime Runtime
}

type JobRuntime struct {
	Runtime Runtime
	Job     Job
}

type StepRuntime struct {
	Runtime Runtime
	Job     Job
	Step    Step
}

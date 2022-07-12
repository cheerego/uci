package facade

var Facades *Facade

type Facade struct {
	WorkflowFacade *WorkflowFacade
	RunnerFacade   *RunnerFacade
	PipelineFacade *PipelineFacade
}

func NewFacade(workflowFacade *WorkflowFacade, runnerFacade *RunnerFacade, pipelineFacade *PipelineFacade) *Facade {
	return &Facade{WorkflowFacade: workflowFacade, RunnerFacade: runnerFacade, PipelineFacade: pipelineFacade}
}

func Register() error {
	Facades = NewFacade(
		NewWorkflowFacade(),
		NewRunnerFacade(),
		NewPipelineFacade(),
	)
	return nil
}

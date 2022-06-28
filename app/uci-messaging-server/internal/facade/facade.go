package facade

var Facades *Facade

type Facade struct {
	WorkflowFacade *WorkflowFacade
	RunnerFacade   *RunnerFacade
}

func NewFacade(workflowFacade *WorkflowFacade, runnerFacade *RunnerFacade) *Facade {
	return &Facade{WorkflowFacade: workflowFacade, RunnerFacade: runnerFacade}
}

func Register() error {
	Facades = NewFacade(
		NewWorkflowFacade(),
		NewRunnerFacade(),
	)
	return nil
}

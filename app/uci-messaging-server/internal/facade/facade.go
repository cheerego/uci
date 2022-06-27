package facade

var Facades *Facade

type Facade struct {
	WorkflowFacade *WorkflowFacade
}

func NewFacade(workflowFacade *WorkflowFacade) *Facade {
	return &Facade{WorkflowFacade: workflowFacade}
}

func Register() error {
	Facades = NewFacade(
		NewWorkflowFacade(),
	)
	return nil
}

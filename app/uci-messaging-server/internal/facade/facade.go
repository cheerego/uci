package facade

var Facades *Facade

type Facade struct {
	MessagingFacade *MessagingFacade
	WorkflowFacade  *WorkflowFacade
}

func NewFacade(messagingFacade *MessagingFacade, workflowFacade *WorkflowFacade) *Facade {
	return &Facade{MessagingFacade: messagingFacade, WorkflowFacade: workflowFacade}
}

func Register() error {
	Facades = NewFacade(
		NewMessagingFacade(),
		NewWorkflowFacade())
	return nil
}

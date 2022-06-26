package facade

var Facades *Facade

type Facade struct {
	MessagingFacade *MessagingFacade
	WorkflowFacade  *WorkflowFacade
	AmqpFacade      *AmqpFacade
	QueueFacade     *QueueFacade
}

func NewFacade(messagingFacade *MessagingFacade, workflowFacade *WorkflowFacade, amqpFacade *AmqpFacade, queueFacade *QueueFacade) *Facade {
	return &Facade{MessagingFacade: messagingFacade, WorkflowFacade: workflowFacade, AmqpFacade: amqpFacade, QueueFacade: queueFacade}
}

func Register() error {
	Facades = NewFacade(
		NewMessagingFacade(),
		NewWorkflowFacade(),
		NewAmqpFacade(),
		NewQueueFacade(),
	)
	return nil
}

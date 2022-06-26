package facade

var Facades *Facade

type Facade struct {
	MessagingFacade  *MessagingFacade
	WorkflowFacade   *WorkflowFacade
	AmqpFacade       *AmqpFacade
	RedisQueueFacade *RedisQueueFacade
	LockKeyFacade    *LockKeyFacade
}

func NewFacade(messagingFacade *MessagingFacade, workflowFacade *WorkflowFacade, amqpFacade *AmqpFacade, queueFacade *RedisQueueFacade, lockKeyFacade *LockKeyFacade) *Facade {
	return &Facade{MessagingFacade: messagingFacade, WorkflowFacade: workflowFacade, AmqpFacade: amqpFacade, RedisQueueFacade: queueFacade, LockKeyFacade: lockKeyFacade}
}

func Register() error {
	Facades = NewFacade(
		NewMessagingFacade(),
		NewWorkflowFacade(),
		NewAmqpFacade(),
		NewRedisQueueFacade(),
		NewLockKeyFacade(),
	)
	return nil
}

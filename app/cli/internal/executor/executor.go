package executor

type IExecutor interface {
	Start(payload string) error
}

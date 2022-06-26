package facade

import "fmt"

type LockKeyFacade struct {
}

func NewLockKeyFacade() *LockKeyFacade {
	return &LockKeyFacade{}
}

func (l *LockKeyFacade) GetPipelineLifecycleLockKey(pipelineId uint32) string {
	return fmt.Sprintf("uci-messaging-server:lock:lifecycle:pipeline-%d", pipelineId)
}

func (l *LockKeyFacade) GetRunnerBorrowLockKey(runnerId uint32) string {
	return fmt.Sprintf("uci-messaging-server:lock:borrow:runner-%d", runnerId)
}
func (l *LockKeyFacade) GetCheckBuildQueuingSchedulerLockKey() string {
	return fmt.Sprintf("uci-messaging-server:lock:cron:check-build-queuing")
}

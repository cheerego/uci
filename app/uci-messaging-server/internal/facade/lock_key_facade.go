package facade

import (
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
)

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

// 定时任务
func (l *LockKeyFacade) GetRevealPipelineStatusSchedulerLockKey(status pipeline.Status) string {
	return fmt.Sprintf("uci-messaging-server:lock:cron:reveal-%s", string(status))
}

func (l *LockKeyFacade) GetSmembersWaitForBuildQueuingLockKey(status pipeline.Status) string {
	return fmt.Sprintf("uci-messaging-server:lock:cron:smembers-%s", string(status))
}

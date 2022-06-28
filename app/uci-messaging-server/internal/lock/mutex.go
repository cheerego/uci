package lock

import (
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
)

func GetPipelineLifecycleLockKey(pipelineId uint32) string {
	return fmt.Sprintf("uci-messaging-server:lock:lifecycle:pipeline-%d", pipelineId)
}

func GetRunnerBorrowLockKey(runnerId uint32) string {
	return fmt.Sprintf("uci-messaging-server:lock:borrow:runner-%d", runnerId)
}

func GetRunnerDiscoveryKey(runnerId uint32) string {
	return fmt.Sprintf("uci-messaging-server:discovery:runner:%d", runnerId)
}

// 定时任务
func GetRevealPipelineStatusSchedulerLockKey(status pipeline.Status) string {
	return fmt.Sprintf("uci-messaging-server:lock:cron:reveal-%s", string(status))
}

func GetSmembersWaitForBuildQueuingLockKey(status pipeline.Status) string {
	return fmt.Sprintf("uci-messaging-server:lock:cron:smembers-%s", string(status))
}

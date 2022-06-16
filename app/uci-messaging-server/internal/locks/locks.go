package locks

import "fmt"

func GetPipelineLifecycleLockKey(pipelineId uint32) string {
	return fmt.Sprintf("uci-messaging-server:lock:lifecycle:pipeline-%d", pipelineId)
}

func GetRunnerBorrowLockKey(runnerId uint32) string {
	return fmt.Sprintf("uci-messaging-server:lock:borrow:runner-%d", runnerId)
}

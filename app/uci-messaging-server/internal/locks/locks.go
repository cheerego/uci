package locks

import "fmt"

func GetPipelineDispatchLockKey(pipelineId uint32) string {
	return fmt.Sprintf("uci-messaging-server:lock:dispatch:pipeline-%d", pipelineId)
}

func GetRunnerBorrowLockKey(runnerId uint32) string {
	return fmt.Sprintf("uci-messaging-server:lock:borrow:runner-%d", runnerId)
}

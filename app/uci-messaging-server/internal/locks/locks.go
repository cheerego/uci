package locks

import "fmt"

func GetPipelineLockKey(pipelineId uint32) string {
	return fmt.Sprintf("uci-messaging-server:lock:pipeline-%d", pipelineId)
}

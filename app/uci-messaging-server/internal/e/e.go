package e

import (
	"github.com/cheerego/uci/pkg/uerror"
)

var ErrClientOffline = uerror.NewUError(500, "ErrClientOffline", "节点状态离线")

var ErrBorrowRunnerDoubleCheckStatus = uerror.NewUError(500, "ErrBorrowRunnerDoubleCheckStatus", "借 Runner 状态二次检查失败")
var ErrBorrowRunnerNoIdle = uerror.NewUError(500, "ErrBorrowRunnerNoIdle", "借 Runner 无可用节点")
var ErrIllegalPipelineStatus = uerror.NewUError(400, "ErrIllegalPipelineStatus", "不合法的流水线状态")

var ErrListWatchAckIdNotFound = uerror.NewUError(416, "ErrListWatchAckIdNotFound", "消息无法应答")
var ErrListWatchAckTimeout = uerror.NewUError(416, "ErrListWatchAckTimeout", "消息无法应答")

package pipeline

import "github.com/cheerego/uci/frame/status"

//UCI 流水线状态设计
//
//流水线的状态设计，影响到了任务的状态流转。如果流水线的状态设计太少或者不完备会影响流水线状态的一致性。
//流水线的状态设计完整性，可以在各个过程中进行兜底操作。
//
//
// 触发构建预检查失败
// 等待构建（等待下发） QUEUING
// 下发中，下发成功，下发失败，下发超时
// 构建成功
// 构建失败（持久化日志失败，持久化缓存失败，构建节点运行失败），构建超时

type Status = status.Status

const PreCheckFailed Status = status.PreCheckFailed

const BuildQueuing Status = status.BuildQueuing
const WaitForBorrowing Status = status.WaitForBorrowing

const BorrowRunnerTimeouted Status = status.BorrowRunnerTimeouted

const WaitForDispatching Status = status.WaitForDispatching
const DispatchSucceed Status = status.DispatchSucceed
const DispatchFailed Status = status.DispatchFailed
const DispatchTimeouted Status = status.DispatchTimeouted
const SelfHostRunnerDispatchTimeouted Status = status.SelfHostRunnerDispatchTimeouted
const NoAvailableRunnerDispatchTimeouted Status = status.NoAvailableRunnerDispatchTimeouted

const BuildRunning Status = status.BuildRunning
const BuildSucceed Status = status.BuildSucceed
const BuildFailed Status = status.BuildFailed
const BuildTimeouted Status = status.BuildTimeouted

const WaitForAborting Status = status.WaitForAborting
const DispatchAbortSucceed Status = status.DispatchAbortSucceed
const BuildAborted Status = status.BuildAborted

const (
	CachePersistenceError Status = status.CachePersistenceError
	LogPersistenceError   Status = status.LogPersistenceError
	RunnerInternalError   Status = status.RunnerInternalError
	RunnerPrepareError    Status = status.RunnerPrepareError
)

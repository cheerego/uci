package pipeline

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

type Status string

const PreCheckFailed Status = "PRE_CHECK_FAILED"

const BuildQueuing Status = "BUILD_QUEUING"
const WaitForBorrowing Status = "WAIT_FOR_BORROWING"

const BorrowRunnerTimeouted Status = "BORROW_RUNNER_TIMEOUTED"

const WaitForDispatching Status = "WAIT_FOR_DISPATCHING"
const DispatchSucceed Status = "DISPATCH_SUCCEED"
const DispatchFailed Status = "DISPATCH_FAILED"
const DispatchTimeouted Status = "DISPATCH_TIMEOUTED"
const SelfHostRunnerDispatchTimeouted Status = "SELF_HOST_RUNNER_DISPATCH_TIMEOUTED"
const NoAvailableRunnerDispatchTimeouted Status = "NO_AVAILABLE_RUNNER_DISPATCH_TIMEOUTED"

const BuildRunning = "BUILD_RUNNING"
const BuildSucceed Status = "BUILD_SUCCEED"
const BuildFailed Status = "BUILD_FAILED"
const BuildTimeouted Status = "BUILD_TIMEOUTED"

const WaitForDispatchAborting = "WAIT_FOR_ABORTING"
const DispatchAbortSucceed = "DISPATCH_ABORT_SUCCEED"
const BuildAborted = "BUILD_ABORTED"

const (
	CachePersistenceError Status = "CACHE_PERSISTENCE_ERROR"
	LogPersistenceError   Status = "LOG_PERSISTENCE_ERROR"
	RunnerInternalError   Status = "RUNNER_INTERNAL_ERROR"
	RunnerPrepareError    Status = "RUNNER_PREPARE_ERROR"
)

package status

type Status string

const PreCheckFailed Status = "PRE_CHECK_FAILED"

const ErrIllegalPipelineYaml = "ILLEGAL_PIPELINE_YAML"

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

const WaitForAborting = "WAIT_FOR_ABORTING"
const DispatchAbortSucceed = "DISPATCH_ABORT_SUCCEED"
const BuildAborted = "BUILD_ABORTED"

const (
	CachePersistenceError Status = "CACHE_PERSISTENCE_ERROR"
	LogPersistenceError   Status = "LOG_PERSISTENCE_ERROR"
	RunnerInternalError   Status = "RUNNER_INTERNAL_ERROR"
	RunnerPrepareError    Status = "RUNNER_PREPARE_ERROR"
)

var Queuing = []Status{
	BuildQueuing,
	WaitForBorrowing,
	WaitForDispatching,
	DispatchSucceed,
	BuildRunning,
}

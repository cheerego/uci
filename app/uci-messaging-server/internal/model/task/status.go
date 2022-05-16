package task

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

const (
	PreCheckSucceed Status = "PreCheckSucceed"
	PreCheckFailed  Status = "PreCheckFailed"
)

const Queuing Status = "Queuing"

const (
	Issuing Status = "Issuing"

	IssueSucceed Status = "IssueSucceed"
	IssueFailed  Status = "IssueFailed"
	IssueTimeout Status = "IssueTimeout"
)

const (
	BuildSucceed Status = "BuildSucceed"

	BuildFailed            Status = "BuildFailed"
	CachePersistenceFailed Status = "CachePersistenceFailed"
	LogPersistenceFailed   Status = "LogPersistenceFailed"
	RunnerInnerError       Status = "RunnerInnerError"
)
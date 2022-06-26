package scheduler

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/facade"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
)

type SmembersPipelineStatusScheduler struct {
}

func NewSmembersPipelineStatusScheduler() *SmembersPipelineStatusScheduler {
	return &SmembersPipelineStatusScheduler{}
}

var _ IScheduler = (*SmembersPipelineStatusScheduler)(nil)

func (s SmembersPipelineStatusScheduler) Enable(params ...interface{}) (bool, string) {
	return true, facade.Facades.LockKeyFacade.GetSmembersWaitForBuildQueuingLockKey(params[0].(pipeline.Status))
}

func (s SmembersPipelineStatusScheduler) Exec(params ...interface{}) {
	status := params[0].(pipeline.Status)
	ctx := context.TODO()

	ids, err := facade.Facades.RedisQueueFacade.SmembersSet(ctx, status)
	if err != nil {
		return
	}
	_ = ids

}

package scheduler

import (
	"context"
	"github.com/assembla/cony"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/conyer"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/lock"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/snapshot"
	"github.com/cheerego/uci/pkg/z"
	"github.com/streadway/amqp"
	"go.uber.org/zap"
	"strconv"
)

type SmembersPipelineStatusScheduler struct {
}

func NewSmembersPipelineStatusScheduler() *SmembersPipelineStatusScheduler {
	return &SmembersPipelineStatusScheduler{}
}

var _ IScheduler = (*SmembersPipelineStatusScheduler)(nil)

func (s *SmembersPipelineStatusScheduler) Enable(params ...interface{}) (bool, string) {
	return true, lock.GetSmembersWaitForBuildQueuingLockKey(params[0].(pipeline.Status))
}

func (s *SmembersPipelineStatusScheduler) Exec(params ...interface{}) {
	status := params[0].(pipeline.Status)
	ctx := context.TODO()

	ids, err := snapshot.SMembersSet(ctx, status)
	if err != nil {
		z.L().Error("SMembers PipelineStatusScheduler set err", zap.Error(err), zap.String("status", string(status)))
		return
	}

	publisher := s.SwitchPublisher(status)
	for _, id := range ids {
		err := publisher.Publish(amqp.Publishing{
			ContentType: "application/json",
			Body:        []byte(strconv.Itoa(int(id))),
		})
		if err != nil {
			z.L().Error("SMembers PipelineStatusScheduler publish err", zap.Error(err), zap.String("status", string(status)), zap.Uint32("id", id))
			continue
		}
	}
}

func (s *SmembersPipelineStatusScheduler) SwitchPublisher(status pipeline.Status) *cony.Publisher {
	switch status {
	case pipeline.BuildQueuing:
		return conyer.BuildQueuingPublisher
	case pipeline.WaitForBorrowing:
		return conyer.WaitForBorrowingPublisher
	case pipeline.WaitForDispatching:
		return conyer.WaitForDispatchingPublisher
	}
	return nil
}

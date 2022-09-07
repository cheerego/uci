package scheduler

import (
	"context"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/lock"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/rabbit/publisher"
	"github.com/cheerego/uci/pkg/log"
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

	ids, err := SMembersSet(ctx, status)
	if err != nil {
		log.L().Error("SMembers PipelineStatusScheduler set err", zap.Error(err), zap.String("status", string(status)))
		return
	}

	pub, err := publisher.SwitchPublisher(status)
	if err != nil {
		log.L().Error("switch publisher err", zap.Error(err))
		return
	}

	for _, id := range ids {
		err := pub.Publish(amqp.Publishing{
			ContentType: "application/json",
			Body:        []byte(strconv.Itoa(int(id))),
		})
		if err != nil {
			log.L().Error("SMembers PipelineStatusScheduler publish err", zap.Error(err), zap.String("status", string(status)), zap.Uint32("id", id))
			continue
		}
	}
}

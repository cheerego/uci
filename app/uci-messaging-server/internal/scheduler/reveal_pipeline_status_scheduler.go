package scheduler

import (
	"context"
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/lock"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/provider/storage"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/service"
	"github.com/cheerego/uci/pkg/log"
	"go.uber.org/zap"
	"strconv"
)

type RevealPipelineStatusScheduler struct {
}

func NewRevealPipelineStatusScheduler() *RevealPipelineStatusScheduler {
	return &RevealPipelineStatusScheduler{}
}

var _ IScheduler = (*RevealPipelineStatusScheduler)(nil)

func (r *RevealPipelineStatusScheduler) Enable(params ...interface{}) (bool, string) {
	status := params[0].(pipeline.Status)
	return true, lock.GetRevealPipelineStatusSchedulerLockKey(status)
}

func (r *RevealPipelineStatusScheduler) Exec(params ...interface{}) {
	status := params[0].(pipeline.Status)
	ctx := context.TODO()
	pipelines, err := service.Services.PipelineService.FindByStatus(ctx, status)
	if err != nil {
		log.L().Error("check build queuing scheduler, find by status err", zap.Error(err), zap.String("status", string(status)))
		return
	}
	if len(pipelines) == 0 {
		return
	}

	_, err = PublishSet(ctx, status, pipelines...)
	if err != nil {
		log.L().Error("check build queuing scheduler, publish build queueing set", zap.Error(err), zap.String("status", string(status)), zap.Any("pipelines", pipelines))
		return
	}
}

func PublishSet(ctx context.Context, status pipeline.Status, p ...*pipeline.Pipeline) (int64, error) {
	ids := make([]interface{}, 0)
	for _, item := range p {
		ids = append(ids, item.ID)
	}
	return storage.Redis().SAdd(ctx, key(status), ids...).Result()
}

func SMembersSet(ctx context.Context, status pipeline.Status) ([]uint32, error) {
	result, err := storage.Redis().SMembers(ctx, key(status)).Result()
	if err != nil {
		return nil, err
	}
	uint32s := make([]uint32, 0)

	for _, s := range result {
		atoi, err := strconv.Atoi(s)
		if err != nil {
			storage.Redis().SRem(ctx, key(status), s)
			continue
		}
		uint32s = append(uint32s, uint32(atoi))
	}
	return uint32s, nil
}

func SRem(ctx context.Context, status pipeline.Status, id uint32) (int64, error) {
	return storage.Redis().SRem(ctx, key(status), id).Result()
}

func key(s pipeline.Status) string {
	return fmt.Sprintf("UCI_PIPELINE_%s_SET", string(s))
}

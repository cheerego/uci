package facade

import (
	"context"
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/provider"
)

type RedisQueueFacade struct {
}

func NewRedisQueueFacade() *RedisQueueFacade {
	return &RedisQueueFacade{}
}

func (q *RedisQueueFacade) PublishBuildQueuingSet(ctx context.Context, p ...*pipeline.Pipeline) (int64, error) {
	ids := make([]interface{}, len(p))
	for _, item := range p {
		ids = append(ids, item.ID)
	}
	return provider.Redis().SAdd(ctx, q.buildQueuingKey(), ids).Result()
}

func (q *RedisQueueFacade) PublishWaitForBorrowingSet(ctx context.Context, p ...*pipeline.Pipeline) (int64, error) {
	ids := make([]interface{}, len(p))
	for _, item := range p {
		ids = append(ids, item.ID)
	}
	return provider.Redis().SAdd(ctx, q.waitForBorrowingKey(), ids).Result()
}

func (q *RedisQueueFacade) PublishWaitForDispatchingSet(ctx context.Context, p ...*pipeline.Pipeline) (int64, error) {
	ids := make([]interface{}, len(p))
	for _, item := range p {
		ids = append(ids, item.ID)
	}
	return provider.Redis().SAdd(ctx, q.waitForDispatchingKey(), ids).Result()
}

func (q *RedisQueueFacade) buildQueuingKey() string {
	return q.key(pipeline.BuildQueuing)
}

func (q *RedisQueueFacade) waitForBorrowingKey() string {
	return q.key(pipeline.WaitForBorrowing)
}

func (q *RedisQueueFacade) waitForDispatchingKey() string {
	return q.key(pipeline.WaitForDispatching)
}

func (q *RedisQueueFacade) key(s pipeline.Status) string {
	return fmt.Sprintf("UCI_PIPELINE_%s_SET", string(s))
}

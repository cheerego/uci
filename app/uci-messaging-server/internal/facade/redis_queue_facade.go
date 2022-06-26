package facade

import (
	"context"
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/provider"
	"strconv"
)

type RedisQueueFacade struct {
}

func NewRedisQueueFacade() *RedisQueueFacade {
	return &RedisQueueFacade{}
}

func (q *RedisQueueFacade) PublishSet(ctx context.Context, status pipeline.Status, p ...*pipeline.Pipeline) (int64, error) {
	ids := make([]interface{}, len(p))
	for _, item := range p {
		ids = append(ids, item.ID)
	}
	return provider.Redis().SAdd(ctx, q.key(status), ids).Result()
}

func (q *RedisQueueFacade) SmembersSet(ctx context.Context, status pipeline.Status) ([]uint32, error) {
	result, err := provider.Redis().SMembers(ctx, q.key(status)).Result()
	if err != nil {
		return nil, err
	}
	uint32s := make([]uint32, len(result))

	for _, s := range result {
		atoi, err := strconv.Atoi(s)
		if err != nil {
			provider.Redis().SRem(ctx, q.key(status), s)
			continue
		}
		uint32s = append(uint32s, uint32(atoi))
	}
	return uint32s, nil
}

func (q *RedisQueueFacade) key(s pipeline.Status) string {
	return fmt.Sprintf("UCI_PIPELINE_%s_SET", string(s))
}

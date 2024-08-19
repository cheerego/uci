package snapshot

import (
	"context"
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/provider"
	"strconv"
)

func PublishSet(ctx context.Context, status pipeline.Status, p ...*pipeline.Pipeline) (int64, error) {
	ids := make([]interface{}, 0)
	for _, item := range p {
		ids = append(ids, item.ID)
	}
	return provider.Redis().SAdd(ctx, key(status), ids...).Result()
}

func SMembersSet(ctx context.Context, status pipeline.Status) ([]uint32, error) {
	result, err := provider.Redis().SMembers(ctx, key(status)).Result()
	if err != nil {
		return nil, err
	}
	uint32s := make([]uint32, 0)

	for _, s := range result {
		atoi, err := strconv.Atoi(s)
		if err != nil {
			provider.Redis().SRem(ctx, key(status), s)
			continue
		}
		uint32s = append(uint32s, uint32(atoi))
	}
	return uint32s, nil
}

func SRem(ctx context.Context, status pipeline.Status, id int64) (int64, error) {
	return provider.Redis().SRem(ctx, key(status), id).Result()
}

func key(s pipeline.Status) string {
	return fmt.Sprintf("UCI_PIPELINE_%s_SET", string(s))
}

package watcher

import (
	"encoding/json"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/e"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cheerego/uci/protocol/letter"
	"github.com/cockroachdb/errors"
	"go.uber.org/zap"
	"sync"
)

var subscribers = sync.Map{}

func Subscribers() []string {
	m := make([]string, 0)
	subscribers.Range(func(key, value any) bool {
		m = append(m, key.(string))
		return true
	})
	return m
}

func Subscribe(name string) (chan string, error) {
	_, ok := subscribers.Load(name)
	if ok {
		return nil, errors.Newf("node had subscribed, %s", name)
	}
	ch := make(chan string, 100)
	subscribers.Store(name, ch)
	return ch, nil
}

func Load(name string) (any, bool) {
	return subscribers.Load(name)
}

func Unsubscribe(name string) {
	_, loaded := subscribers.LoadAndDelete(name)
	if !loaded {
		log.L().Warn("取消监听，但监听不存在", zap.String("Name", name))
	}
}

func Publish(clientId string, letter *letter.Letter) error {
	ch, load := Load(clientId)
	marshal, err := json.Marshal(letter)
	if err != nil {
		return err
	}
	if load {
		ch.(chan string) <- string(marshal)
		return nil
	}
	return e.ErrClientOffline.WithStack()
}

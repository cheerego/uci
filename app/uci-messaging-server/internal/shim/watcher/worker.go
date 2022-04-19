package watcher

import (
	"github.com/cheerego/uci/pkg/log"
	"github.com/cockroachdb/errors"
	"go.uber.org/zap"
	"sync"
)

var subscribers sync.Map

func Subscriber() sync.Map {
	return subscribers
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
		log.Warn("取消监听，但监听不存在", zap.String("Name", name))
	}
}

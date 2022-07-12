package watcher

import (
	"encoding/json"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/e"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cheerego/uci/pkg/syncmap"
	"github.com/cheerego/uci/protocol/letter"
	"github.com/cockroachdb/errors"
	"go.uber.org/zap"
)

type ListWatcher struct {
	acks        *syncmap.Map[chan struct{}]
	subscribers *syncmap.Map[chan string]
}

func NewListWatcher() *ListWatcher {
	return &ListWatcher{acks: syncmap.New[chan struct{}](), subscribers: syncmap.New[chan string]()}
}

func (l *ListWatcher) Subscribers() []string {
	m := make([]string, 0)
	l.subscribers.Range(func(key, value any) bool {
		m = append(m, key.(string))
		return true
	})
	return m
}

func (l *ListWatcher) Subscribe(name string) (chan string, error) {
	_, ok := l.subscribers.Load(name)
	if ok {
		return nil, errors.Newf("node had subscribed, %s", name)
	}
	ch := make(chan string, 100)
	l.subscribers.Store(name, ch)
	return ch, nil
}

func (l *ListWatcher) Load(name string) (any, bool) {
	return l.subscribers.Load(name)
}

func (l *ListWatcher) Unsubscribe(name string) {
	_, loaded := l.subscribers.LoadAndDelete(name)
	if !loaded {
		log.L().Warn("取消监听，但监听不存在", zap.String("Name", name))
	}
}

func (l *ListWatcher) Publish(clientId string, letter *letter.Letter) error {
	ch, load := l.Load(clientId)
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

func (l *ListWatcher) PublishAck(clientId string, letter *letter.Letter) error {
	err := l.Publish(clientId, letter)
	if err != nil {
		return err
	}
	ch := make(chan struct{}, 10)
	l.acks.Store(letter.RequestId, ch)

	return err
}

func (l *ListWatcher) Ack(requestId string) error {
	load, b := l.acks.Load(requestId)
	if !b {
		return e.ErrNoListWatchAckId.WithStack()
	}
	load <- struct{}{}
	return nil
}

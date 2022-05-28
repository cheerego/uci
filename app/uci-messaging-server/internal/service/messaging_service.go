package service

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/shim/watcher"
	"github.com/cheerego/uci/protocol/letter"
)

type MessagingService struct {
}

func NewMessagingService() *MessagingService {
	return &MessagingService{}
}

func (m *MessagingService) Publish(clientId string, l *letter.Letter) error {
	return watcher.Publish(clientId, l)

}

func (m *MessagingService) Subscribe(clientId string) (chan string, error) {
	return watcher.Subscribe(clientId)
}

func (m *MessagingService) Load(name string) (any, bool) {
	return watcher.Load(name)
}

func (m *MessagingService) Unsubscribe(name string) {
	watcher.Unsubscribe(name)
}

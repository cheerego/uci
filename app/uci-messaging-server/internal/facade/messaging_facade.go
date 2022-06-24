package facade

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/shim/watcher"
	"github.com/cheerego/uci/protocol/letter"
)

type MessagingFacade struct {
}

func NewMessagingFacade() *MessagingFacade {
	return &MessagingFacade{}
}

func (m *MessagingFacade) Publish(clientId string, l *letter.Letter) error {
	return watcher.Publish(clientId, l)

}

func (m *MessagingFacade) Subscribe(clientId string) (chan string, error) {
	return watcher.Subscribe(clientId)
}

func (m *MessagingFacade) Load(name string) (any, bool) {
	return watcher.Load(name)
}

func (m *MessagingFacade) Unsubscribe(name string) {
	watcher.Unsubscribe(name)
}

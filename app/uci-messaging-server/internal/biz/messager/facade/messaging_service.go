package facade

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/biz/messager/internal/shim/watcher"
	"github.com/cheerego/uci/protocol/letter"
)

func Publish(clientId string, l *letter.Letter) error {
	return watcher.Publish(clientId, l)

}

func Subscribe(clientId string) (chan string, error) {
	return watcher.Subscribe(clientId)
}

func Load(name string) (any, bool) {
	return watcher.Load(name)
}

func Unsubscribe(name string) {
	watcher.Unsubscribe(name)
}

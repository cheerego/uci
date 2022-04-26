package shim

import (
	"github.com/cheerego/uci/app/uci/internal/config"
	"go.etcd.io/bbolt"
	"path"
)

type BaseShimer struct {
	Bolt *bbolt.DB
}

var dbName = "uci.db"

func NewBaseShimer() (*BaseShimer, error) {
	db, err := bbolt.Open(path.Join(config.Configs.UciHomeDir, dbName), 0600, nil)
	if err != nil {
		return nil, err
	}
	return &BaseShimer{
		Bolt: db,
	}, nil
}

func (b *BaseShimer) WriteMessageToStorage(payload string) error {
	return nil
}

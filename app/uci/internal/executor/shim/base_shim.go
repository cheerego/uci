package shim

import (
	"github.com/mitchellh/go-homedir"
	"go.etcd.io/bbolt"
	"path"
)

type BaseShimer struct {
	Bolt *bbolt.DB
}

func NewBaseShimer() (*BaseShimer, error) {
	dir, err := homedir.Dir()
	if err != nil {
		return nil, err
	}

	db, err := bbolt.Open(path.Join(dir, "uci", "uci.db"), 0600, nil)
	return &BaseShimer{
		Bolt: db,
	}, nil
}

func (b *BaseShimer) WriteMessageToStorage(payload string) error {
	return nil
}

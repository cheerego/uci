package storage

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/config"
	"github.com/cheerego/uci/pkg/db"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

var storages *Storage

type Storage struct {
	masterDB *gorm.DB
}

func NewStorage(masterDB *gorm.DB) *Storage {
	return &Storage{masterDB: masterDB}
}

func MasterDB() *gorm.DB {
	return storages.masterDB
}

func init() {
	g, err := db.New(config.Configs.GormMasterDSN, config.Configs.GormMasterPoolConfig)
	if err != nil {
		zap.L().Fatal("new db err connect err", zap.Error(err))
	}

	storages = NewStorage(g)
}

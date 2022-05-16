package storage

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/config"
	"github.com/cheerego/uci/pkg/orm"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

var storages *Storage

type Storage struct {
	masterDB *gorm.DB
}

func MasterDB() *gorm.DB {
	return storages.masterDB
}

func NewStorage(masterDB *gorm.DB) *Storage {
	return &Storage{masterDB: masterDB}
}

func init() {
	zap.L().Info("master dsn", zap.Any("config", config.Configs.GormMasterDSN))
	g, err := orm.New(config.Configs.GormMasterDSN, config.Configs.GormMasterPoolConfig)
	if err != nil {
		zap.L().Fatal("new orm err connect err", zap.Error(err))
	}

	storages = NewStorage(g)
}

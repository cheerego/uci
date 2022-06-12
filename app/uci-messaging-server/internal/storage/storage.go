package storage

import (
	"context"
	"github.com/cheerego/go-redisson"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/config"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cheerego/uci/pkg/orm"
	"github.com/go-redis/redis/v8"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

var Storages *Storage

type Storage struct {
	masterDB *gorm.DB
	redis    *redis.Client
	godisson *godisson.Godisson
}

func NewStorage(masterDB *gorm.DB, redis *redis.Client, godisson *godisson.Godisson) *Storage {
	return &Storage{masterDB: masterDB, redis: redis, godisson: godisson}
}

func MasterDB() *gorm.DB {
	return Storages.masterDB
}

func Redis() *redis.Client {
	return Storages.redis
}

func Godisson() *godisson.Godisson {
	return Storages.godisson
}

func Register() error {
	log.L().Info("master dsn", zap.Any("config", config.Configs.GormMasterDSN))
	g, err := orm.New(config.Configs.GormMasterDSN, config.Configs.GormMasterPoolConfig)
	if err != nil {
		return err
	}

	// create redis client
	rdb := redis.NewClient(&redis.Options{
		Addr:     "redis:6379",
		Password: "", // no password set
		DB:       0,  // use default DB
	})
	_, err = rdb.Ping(context.TODO()).Result()
	if err != nil {
		return err
	}

	newGodisson := godisson.NewGodisson(rdb)
	Storages = NewStorage(g, rdb, newGodisson)
	return nil
}

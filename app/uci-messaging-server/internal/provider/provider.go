package provider

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

var Providers *Provider

type Provider struct {
	masterDB *gorm.DB
	redis    *redis.Client
	godisson *godisson.Godisson
}

func NewStorage(masterDB *gorm.DB, redis *redis.Client, godisson *godisson.Godisson) *Provider {
	return &Provider{masterDB: masterDB, redis: redis, godisson: godisson}
}

func MasterDB() *gorm.DB {
	return Providers.masterDB
}

func Redis() *redis.Client {
	return Providers.redis
}

func Godisson() *godisson.Godisson {
	return Providers.godisson
}

func Register() error {
	db, err := initDB()
	if err != nil {
		return err
	}

	rdb, g, err := initRedis()
	if err != nil {
		return err
	}

	Providers = NewStorage(db, rdb, g)
	return nil
}

func initDB() (*gorm.DB, error) {
	log.Info("master dsn", zap.Any("config", config.Configs.GormMasterDSN))
	g, err := orm.New(config.Configs.GormMasterDSN, config.Configs.GormMasterPoolConfig)
	if err != nil {
		return nil, err
	}
	return g, nil
}

func initRedis() (*redis.Client, *godisson.Godisson, error) {
	// create redis client
	rdb := redis.NewClient(&redis.Options{
		Addr:     "redis:6379",
		Password: "", // no password set
		DB:       0,  // use default DB
	})
	_, err := rdb.Ping(context.TODO()).Result()
	if err != nil {
		return nil, nil, err
	}
	newGodisson := godisson.NewGodisson(rdb)
	return rdb, newGodisson, nil
}

package provider

import (
	"context"
	godisson "github.com/cheerego/go-redisson"
	"github.com/cheerego/uci/app/twilight/internal/config"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cheerego/uci/pkg/orm"
	"github.com/go-redis/redis/v8"
	"go.uber.org/zap"
	"gorm.io/gorm"
	"net"
	"net/http"
	"time"
)

var Providers *Provider

type Provider struct {
	masterDB     *gorm.DB
	redis        *redis.Client
	godisson     *godisson.Godisson
	runnerClient *http.Client
}

func NewProvider(masterDB *gorm.DB, redis *redis.Client, godisson *godisson.Godisson, runnerHttpClient *http.Client) *Provider {
	return &Provider{masterDB: masterDB, redis: redis, godisson: godisson, runnerClient: runnerHttpClient}
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
func RunnerClient() *http.Client {
	return Providers.runnerClient
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

	client := initRunnerHttpClient()

	Providers = NewProvider(db, rdb, g, client)
	return nil
}

func initDB() (*gorm.DB, error) {
	log.L().Info("master dsn", zap.Any("config", config.Configs.GormMasterDSN))
	g, err := orm.New(config.Configs.GormMasterDSN, config.Configs.GormMasterPoolConfig)
	if err != nil {
		return nil, err
	}
	return g, nil
}

func initRedis() (*redis.Client, *godisson.Godisson, error) {
	// create redis client
	rdb := redis.NewClient(&redis.Options{
		Addr:     config.Configs.RedisDSN,
		Password: config.Configs.RedisPassword, // no password set
		DB:       0,                            // use default DB
	})
	_, err := rdb.Ping(context.TODO()).Result()
	if err != nil {
		return nil, nil, err
	}
	newGodisson := godisson.NewGodisson(rdb)
	return rdb, newGodisson, nil
}

func initRunnerHttpClient() *http.Client {
	return &http.Client{
		Transport: &http.Transport{
			Dial: (&net.Dialer{
				//	建立握手的超时事件
				Timeout:   10 * time.Second,
				KeepAlive: 100 * time.Second,
			}).Dial,
			//TLSHandshakeTimeout:   10 * time.Second,
			//ResponseHeaderTimeout: 10 * time.Second,
			//ExpectContinueTimeout: 1 * time.Second,
		},
		Timeout: 0,
	}

}

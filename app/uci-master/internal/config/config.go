package config

import (
	"github.com/caarlos0/env/v6"
	"github.com/cheerego/uci/pkg/log"
	"go.uber.org/zap"
)

var Configs Config

type Config struct {
	HttpPort             int    `env:"HTTP_PORT" envDefault:"8080"`
	GormMasterDSN        string `env:"GORM_MASTER_DSN,required"`
	RedisDSN             string `env:"REDIS_DSN"`
	RedisPassword        string `env:"REDIS_PASSWORD"`
	GormMasterPoolConfig string `env:"GORM_MASTER_POOL_CONFIG" envDefault:"MaxOpenConns=100&MaxIdleConns=50&ConnMaxIdleTime=1200&ConnMaxLifetime=1800"`

	//amqp://guest:guest@localhost
	RabbitAddrUrl string `env:"RABBIT_ADDR_URL,required"`
}

func Register() error {
	var c Config
	if err := env.Parse(&c); err != nil {
		return err
	}

	Configs = c
	log.Info("config: ", zap.Any("Config", Configs))
	return nil
}

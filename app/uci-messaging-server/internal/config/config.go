package config

import (
	"github.com/caarlos0/env/v6"
	"github.com/cheerego/uci/pkg/log"
	"go.uber.org/zap"
)

var Configs Config

type Config struct {
	HttpPort             int    `env:"HTTP_PORT" envDefault:8080`
	GormMasterDSN        string `env:"GORM_MASTER_DSN,required" envDefault:host=localhost user=gorm password=gorm dbname=gorm port=9920 sslmode=disable TimeZone=Asia/Shanghai`
	GormMasterPoolConfig string `env:"GORM_MASTER_POOL_CONFIG" envDefault:MaxOpenConns=100&MaxIdleConns=50&ConnMaxIdleTime=1200&ConnMaxLifetime=1800`

	//amqp://guest:guest@localhost
	RabbitAddrUrl string `env:"RABBIT_ADDR_URL,required"`
}

func Register() error {
	if err := env.Parse(&Configs); err != nil {
		return err
	}
	log.L().Info("config: ", zap.Any("Config", Configs))
	return nil
}

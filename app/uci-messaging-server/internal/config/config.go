package config

import (
	"github.com/caarlos0/env/v6"
	"go.uber.org/zap"
)

var Configs Config

type Config struct {
	HttpPort       int    `env:"HTTP_PORT" envDefault:8080`
	GormDSN        string `env:"GORM_DSN,required" envDefault:host=localhost user=gorm password=gorm dbname=gorm port=9920 sslmode=disable TimeZone=Asia/Shanghai`
	GormPoolConfig string `env:"GORM_POOL_CONFIG" envDefault:MaxOpenConns=100&MaxIdleConns=50&ConnMaxIdleTime=1200&ConnMaxLifetime=1800`
}

func init() {
	if err := env.Parse(&Configs); err != nil {
		zap.L().Fatal("parse config err", zap.Error(err))
	}
}

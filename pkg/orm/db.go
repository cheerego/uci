package orm

import (
	"database/sql"
	"github.com/cockroachdb/errors"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
	"log"
	"os"
	"time"
)

func New(dsn string, dbPoolConfig string) (*gorm.DB, error) {
	//host=localhost user=gorm password=gorm dbname=gorm port=9920 sslmode=disable TimeZone=Asia/Shanghai
	//MaxOpenConns=256&MaxIdleConns=100&ConnMaxIdleTime=1200&ConnMaxLifetime=1800
	g, err := gorm.Open(postgres.Open(dsn), &gorm.Config{
		SkipDefaultTransaction: true,
		Logger: logger.New(log.New(os.Stdout, "\r\n", log.LstdFlags), logger.Config{
			SlowThreshold:             200 * time.Millisecond,
			LogLevel:                  logger.Info,
			IgnoreRecordNotFoundError: true,
			Colorful:                  true,
		}),
	})
	if err != nil {
		return nil, errors.Wrapf(err, "dial orm error, dsn %s", dsn)
	}
	db, err := g.DB()
	err = setDBPool(db, dbPoolConfig)
	if err != nil {
		return nil, err
	}
	return g, nil
}

func setDBPool(db *sql.DB, dbPoolConfig string) error {
	values, err := ParseDBPoolConfig(dbPoolConfig)
	if err != nil {
		return errors.Wrapf(err, "parse orm pool config err, config: %s", dbPoolConfig)
	}
	db.SetMaxOpenConns(GetOrDefault(values, "MaxOpenConns", 100))
	db.SetMaxIdleConns(GetOrDefault(values, "MaxIdleConns", 50))
	db.SetConnMaxIdleTime(time.Duration(GetOrDefault(values, "ConnMaxIdleTime", 1200)) * time.Second)
	db.SetConnMaxLifetime(time.Duration(GetOrDefault(values, "ConnMaxLifetime", 1800)) * time.Second)
	return nil
}

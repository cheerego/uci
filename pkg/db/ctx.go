package db

import (
	"context"
	"gorm.io/gorm"
)

var key string = "ctx-gorm"

func FromContext(ctx context.Context, defaultDB *gorm.DB) *gorm.DB {
	db, ok := ctx.Value(key).(*gorm.DB)
	if ok {
		return db
	}
	return defaultDB
}

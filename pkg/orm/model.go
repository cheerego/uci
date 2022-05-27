package orm

import (
	"gorm.io/gorm"
	"time"
)

type Model struct {
	ID        uint32 `gorm:"primarykey"`
	CreatedAt time.Time
	UpdatedAt time.Time
	DeletedAt gorm.DeletedAt `gorm:"index"`
}

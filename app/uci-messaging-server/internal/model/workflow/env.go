package workflow

import (
	"database/sql/driver"
	"encoding/json"
	"github.com/cheerego/uci/pkg/log"
	"go.uber.org/zap"
)

type Env struct {
	Key    string `json:"key"`
	LValue string `json:"value"`
	//Sensitive bool   `json:"sensitive"`
}

type Envs []*Env

// gorm 自定义结构需要实现 Value Scan 两个方法
// Value 实现方法
func (p Envs) Value() (driver.Value, error) {
	log.L().Info("envs value", zap.Any("p", p))
	return json.Marshal(p)
}

// Scan 实现方法
func (p *Envs) Scan(data interface{}) error {
	log.L().Info("envs data", zap.Any("p", string(data.([]byte))))
	return json.Unmarshal(data.([]byte), p)
}

// gorm 自定义结构需要实现 LValue Scan 两个方法
// LValue 实现方法
func (p Env) Value() (driver.Value, error) {
	log.L().Info("envs value", zap.Any("p", p))
	return json.Marshal(p)
}

// Scan 实现方法
func (p *Env) Scan(data interface{}) error {
	log.L().Info("envs data", zap.Any("p", string(data.([]byte))))
	return json.Unmarshal(data.([]byte), p)
}

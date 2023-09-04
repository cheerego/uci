package model

import (
	"github.com/cheerego/uci/pkg/orm"
)

type Runner struct {
	orm.Model
	Enable bool
	Host   string
	Port   int
}

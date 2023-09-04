package model

import (
	"fmt"
	"github.com/cheerego/uci/pkg/orm"
)

type Runner struct {
	orm.Model
	Enable bool
	Host   string
	Port   int
}

func (r *Runner) Addr() string {
	return fmt.Sprintf("%s:%d", r.Host, r.Port)
}

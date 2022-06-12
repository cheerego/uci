package runner

import (
	"github.com/cheerego/uci/pkg/orm"
	"time"
)

type Runner struct {
	orm.Model
	MachineCode string
	Salt        string
	Status      Status

	ConfigLoad  int32
	CurrentLoad int32
	LoadMode    string

	LastStatusChangedAt time.Time
	LastDispatchAt      time.Time
}

func (r Runner) TableName() string {
	return "runners"
}

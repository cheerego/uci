package runner

import (
	"fmt"
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

func (r *Runner) LogName() string {
	return fmt.Sprintf("runner-%d-salt-%s-machine-%s", r.ID, r.Salt, r.MachineCode)
}

func (r Runner) TableName() string {
	return "runners"
}

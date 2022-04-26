package executor

import (
	"github.com/cheerego/uci/app/uci/internal/executor/shim"
)

type Uci struct {
	shim shim.Shimer
}

func NewUci(shim shim.Shimer) *Uci {
	return &Uci{
		shim,
	}
}

// PreCheck 检查 go 程序收存在
// 检查监听的 URL 配置是否存在
//
func (u *Uci) PreCheck() error {
	return nil
}

func (u *Uci) Start() error {
	return u.shim.StartListener()
}

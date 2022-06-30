package internal

import (
	"context"
	"github.com/cheerego/uci/app/cli/internal/messaging"
	"github.com/cheerego/uci/app/cli/internal/precheck"
	"github.com/cockroachdb/errors"
	"github.com/spf13/cobra"
)

type Uci struct {
	BaseShimer *messaging.BaseShimer
	Context    context.Context
	Cancel     context.CancelFunc
}

func NewUci(shim messaging.Shimer) *Uci {
	cancel, cancelFunc := context.WithCancel(context.Background())
	return &Uci{
		BaseShimer: messaging.NewBaseShimer(shim),
		Context:    cancel,
		Cancel:     cancelFunc,
	}
}

func (u *Uci) Root() *cobra.Command {
	root := &cobra.Command{
		Use:   "executor",
		Short: "executor is a simple CI execute engine",
		Long:  `executor is a simple CI execute engine, message communicate by List And Watch、Websocket、RabbitMQ`,
		Run: func(cmd *cobra.Command, args []string) {
			cmd.Help()
		},
	}
	root.AddCommand(u.Up())
	config := u.Config()
	config.AddCommand(u.ConfigSet())
	config.AddCommand(u.ConfigGet())
	config.AddCommand(u.ConfigList())
	config.AddCommand(u.ConfigDelete())
	root.AddCommand(config)
	return root
}

// Check 检查 go 程序收存在
// 检查监听的 URL 配置是否存在
//
func (u *Uci) Check() error {
	return errors.CombineErrors(
		precheck.NewProxy().RunCheck(),
		precheck.NewGit().RunCheck(),
	)
}

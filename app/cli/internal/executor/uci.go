package executor

import (
	"context"
	"github.com/cheerego/uci/app/cli/internal/executor/shim"
	"github.com/cheerego/uci/pkg/log"
	"github.com/mitchellh/go-homedir"
	"github.com/spf13/cobra"
	"go.uber.org/zap"
	"path"
)

type Uci struct {
	shim shim.Shimer
}

func NewUci(shim shim.Shimer) *Uci {
	return &Uci{
		shim,
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
	return root
}

func (u *Uci) Up() *cobra.Command {
	up := &cobra.Command{
		Use:   "up",
		Short: "start a shim for messaging",
		Long:  "start a shim for messaging",
		Run: func(cmd *cobra.Command, args []string) {
			u.Start(context.Background())
		},
	}
	return up
}

// PreCheck 检查 go 程序收存在
// 检查监听的 URL 配置是否存在
//
func (u *Uci) PreCheck() error {
	return nil
}

func (u *Uci) Start(ctx context.Context) error {
	return u.shim.StartListener(ctx)
}

func init() {
	dir, _ := homedir.Dir()
	cli, err := log.Cli(log.DefaultLogLevel(), path.Join(dir, "uci", "uci.log"))
	if err != nil {
		panic(any(err))
	}
	zap.ReplaceGlobals(cli)
}

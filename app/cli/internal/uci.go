package internal

import (
	"context"
	"github.com/cheerego/uci/app/cli/internal/messaging"
	"github.com/cheerego/uci/app/cli/internal/precheck"
	"github.com/cockroachdb/errors"
	"github.com/spf13/cobra"
	"go.uber.org/zap"
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
	return root
}

func (u *Uci) Up() *cobra.Command {
	up := &cobra.Command{
		Use:   "up",
		Short: "start a shim for messaging",
		Long:  "start a shim for messaging",
		PreRun: func(cmd *cobra.Command, args []string) {
			err := u.Check()
			if err != nil {
				zap.S()
				zap.S().Fatalf("PreRun Check err %s", err.Error())
			}
		},
		Run: func(cmd *cobra.Command, args []string) {
			if err := u.BaseShimer.Run(u.Context); err != nil {
				zap.L().Error("runner shimer run err", zap.Error(err))
			}
		},
	}
	return up
}

func (u *Uci) Stop() *cobra.Command {
	up := &cobra.Command{
		Use:   "stop",
		Short: "Stop UCI runner",
		Long:  "Stop UCI runner",
		RunE: func(cmd *cobra.Command, args []string) error {
			zap.L().Info("stop uci runner")
			return nil
		},
	}
	return up
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

package internal

import (
	"context"
	"github.com/cheerego/uci/app/cli/internal/messaging"
	"github.com/cheerego/uci/app/cli/internal/precheck"
	"github.com/cheerego/uci/pkg/log"
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
	config := u.Config()
	config.AddCommand(u.ConfigSet())
	config.AddCommand(u.ConfigGet())
	config.AddCommand(u.ConfigList())
	config.AddCommand(u.ConfigDelete())
	root.AddCommand(config)
	return root
}

func (u *Uci) Up() *cobra.Command {
	return &cobra.Command{
		Use:   "up",
		Short: "start a shim for messaging",
		Long:  "start a shim for messaging",
		PreRun: func(cmd *cobra.Command, args []string) {
			err := u.Check()
			if err != nil {
				log.S().Fatalf("PreRun Check err %s", err.Error())
			}
		},
		Run: func(cmd *cobra.Command, args []string) {
			if err := u.BaseShimer.Run(u.Context); err != nil {
				log.L().Error("runner shimer run err", zap.Error(err))
			}
		},
	}
}

func (u *Uci) Stop() *cobra.Command {
	return &cobra.Command{
		Use:   "stop",
		Short: "Stop UCI runner",
		Long:  "Stop UCI runner",
		RunE: func(cmd *cobra.Command, args []string) error {
			log.L().Info("stop uci runner")
			return nil
		},
	}
}

func (u *Uci) Config() *cobra.Command {
	return &cobra.Command{
		Use:  "config",
		Long: "Manage the npm configuration files",
		Example: `
uci config set <key>=<value> [<key>=<value> ...]
uci config get [<key> [<key> ...]]
uci config delete <key> [<key> ...]
uci config list [--json]
`,
		Args: func(cmd *cobra.Command, args []string) error {
			return nil
		},
		Run: func(cmd *cobra.Command, args []string) {
			log.L().Info("stop uci runner", zap.Any("args", args))
		},
	}
}

func (u *Uci) ConfigSet() *cobra.Command {
	return &cobra.Command{
		Use:   "set",
		Short: "set uci config item",
		Args:  cobra.MinimumNArgs(1),
		RunE: func(cmd *cobra.Command, args []string) error {
			log.L().Info("stop uci runner", zap.Any("args", args))
			return nil
		},
	}
}

func (u *Uci) ConfigGet() *cobra.Command {
	return &cobra.Command{
		Use:   "get [<key> [<key> ...]]",
		Short: "get uci config item",
		Args:  cobra.MinimumNArgs(1),
		RunE: func(cmd *cobra.Command, args []string) error {
			return nil
		},
	}
}

func (u *Uci) ConfigList() *cobra.Command {
	return &cobra.Command{
		Use:   "list",
		Short: "list uci config items",
		Args: func(cmd *cobra.Command, args []string) error {
			return nil
		},
		Run: func(cmd *cobra.Command, args []string) {
			log.L().Info("stop uci runner", zap.Any("args", args))
		},
	}
}

func (u *Uci) ConfigDelete() *cobra.Command {
	return &cobra.Command{
		Use:   "delete",
		Short: "delete uci config item",
		Args: func(cmd *cobra.Command, args []string) error {
			return nil
		},
		Run: func(cmd *cobra.Command, args []string) {
			log.L().Info("stop uci runner", zap.Any("args", args))
		},
	}
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

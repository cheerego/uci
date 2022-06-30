package internal

import (
	"github.com/cheerego/uci/pkg/log"
	"github.com/spf13/cobra"
	"go.uber.org/zap"
)

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

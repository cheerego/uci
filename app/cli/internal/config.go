package internal

import (
	"fmt"
	"github.com/cheerego/uci/app/cli/internal/config"
	"github.com/cheerego/uci/pkg/ini"
	"github.com/cheerego/uci/pkg/log"
	"github.com/spf13/cobra"
	"go.uber.org/zap"
	"strings"
)

func (u *Uci) Config() *cobra.Command {
	return &cobra.Command{
		Use:  "config",
		Long: "manager the uci configuration files",
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
			cmd.Help()
		},
	}
}

func (u *Uci) ConfigSet() *cobra.Command {
	return &cobra.Command{
		Use:   "set",
		Short: "set uci config item",
		Args:  cobra.MinimumNArgs(1),
		RunE: func(cmd *cobra.Command, args []string) error {
			newIni := ini.NewIni(config.UciConfigPath())
			for _, arg := range args {
				splits := strings.SplitN(arg, "=", 2)
				newIni.Write(splits[0], splits[1])
			}
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
			m := config.Map()
			if item, ok := m[args[0]]; ok {
				value, err := item.Value()
				if err != nil {
					return err
				}
				fmt.Printf("%s=%s\n", args[0], value)
			} else {
				fmt.Printf("%s=%s\n", args[0], "")
			}
			return nil
		},
	}
}

func (u *Uci) ConfigList() *cobra.Command {
	return &cobra.Command{
		Use:   "list",
		Short: "list uci config items",
		RunE: func(cmd *cobra.Command, args []string) error {
			m := config.Map()
			for name, item := range m {
				value, err := item.Value()
				if err != nil {
					return err
				}
				fmt.Printf("%s=%s\n", name, value)
			}
			return nil
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
			log.Info("stop uci uci-uci-runner", zap.Any("args", args))
		},
	}
}

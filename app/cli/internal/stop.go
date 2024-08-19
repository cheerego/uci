package internal

import (
	"github.com/cheerego/uci/pkg/log"
	"github.com/spf13/cobra"
)

func (u *Uci) Stop() *cobra.Command {
	return &cobra.Command{
		Use:   "stop",
		Short: "Stop UCI uci-uci-runner",
		Long:  "Stop UCI uci-uci-runner",
		RunE: func(cmd *cobra.Command, args []string) error {
			log.Info("stop uci uci-uci-runner")
			return nil
		},
	}
}

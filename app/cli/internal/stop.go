package internal

import (
	"github.com/cheerego/uci/pkg/log"
	"github.com/spf13/cobra"
)

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

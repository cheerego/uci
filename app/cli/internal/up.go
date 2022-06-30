package internal

import (
	"github.com/cheerego/uci/pkg/log"
	"github.com/spf13/cobra"
	"go.uber.org/zap"
)

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

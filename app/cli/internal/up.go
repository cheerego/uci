package internal

import (
	"github.com/cheerego/uci/app/cli/internal/requests"
	"github.com/cheerego/uci/pkg/signal"
	"github.com/cheerego/uci/pkg/z"
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
				z.S().Fatalf("PreRun Check err %s", err.Error())
			}
		},
		Run: func(cmd *cobra.Command, args []string) {
			go func() {
				<-signal.KillSignal()
				u.TerminateCancel()
			}()
			if err := u.BaseShimer.Run(u.TerminateContext); err != nil {
				z.L().Error("runner shim run err", zap.Error(err))
				requests.MessagingUnsubscribe("1")
			}
		},
	}
}

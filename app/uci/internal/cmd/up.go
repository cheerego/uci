package cmd

import (
	"github.com/cheerego/uci/app/uci/internal/executor"
	"github.com/cheerego/uci/app/uci/internal/executor/shim"
	"github.com/spf13/cobra"
	"go.uber.org/zap"
)

var UpCmd = &cobra.Command{
	Use:   "up",
	Short: "start a shim for messaging",
	Long:  "start a shim for messaging",
	Run: func(cmd *cobra.Command, args []string) {
		zap.L().Error("up")
		uci := executor.NewUci(shim.NewListWatch())
		uci.Start()
	},
}

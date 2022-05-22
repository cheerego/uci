package cmd

import (
	"context"
	"github.com/cheerego/uci/app/cli/internal/executor"
	"github.com/cheerego/uci/app/cli/internal/executor/shim"
	"github.com/spf13/cobra"
)

var UpCmd = &cobra.Command{
	Use:   "up",
	Short: "start a shim for messaging",
	Long:  "start a shim for messaging",
	Run: func(cmd *cobra.Command, args []string) {
		uci := executor.NewUci(shim.NewListWatch())
		uci.Start(context.Background())
	},
}

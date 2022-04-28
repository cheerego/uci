package cli

import (
	"fmt"
	"github.com/cheerego/uci/app/cli/internal/cmd"
	"github.com/spf13/cobra"
	"os"
)

func init() {
	rootCmd.AddCommand(cmd.UpCmd)
}

var rootCmd = &cobra.Command{
	Use:   "executor",
	Short: "executor is a simple CI execute engine",
	Long:  `executor is a simple CI execute engine, message communicate by List And Watch、Websocket、RabbitMQ`,
	Run: func(cmd *cobra.Command, args []string) {
		cmd.Help()
	},
}

func Execute() {
	if err := rootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}

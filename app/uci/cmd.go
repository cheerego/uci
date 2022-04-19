package uci

import (
	"fmt"
	"os"
)
import "github.com/spf13/cobra"

var rootCmd = &cobra.Command{
	Use:   "uci",
	Short: "uci is a simple CI execute engine",
	Long:  `uci is a simple CI execute engine, message communicate by List And Watch、Websocket、RabbitMQ`,
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

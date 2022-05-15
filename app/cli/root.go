package cli

import (
	"fmt"
	"github.com/cheerego/uci/app/cli/internal/cmd"
	"github.com/cheerego/uci/pkg/log"
	"github.com/mitchellh/go-homedir"
	"github.com/spf13/cobra"
	"go.uber.org/zap"
	"os"
	"path"
)

func init() {
	dir, _ := homedir.Dir()
	cli, err := log.Cli(log.DefaultLogLevel(), path.Join(dir, "uci", "uci.log"))
	if err != nil {
		panic(any(err))
	}
	zap.ReplaceGlobals(cli)
}

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

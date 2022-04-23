package uci

import (
	"fmt"
	"github.com/cheerego/uci/app/uci/internal/shim"
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

type Uci struct {
	shim.Shimer
}

func NewUci(shim shim.Shimer) *Uci {
	return &Uci{
		shim,
	}
}

// 检查 go 程序收存在
// 检查监听的 URL 配置是否存在
//
func (u *Uci) PreCheck() error {
	return nil
}

func (u *Uci) StartListener() error {
	return u.Shimer.StartListener()
}

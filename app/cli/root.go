package cli

import (
	"fmt"
	"github.com/cheerego/uci/app/cli/internal"
	"github.com/cheerego/uci/app/cli/internal/config"
	"github.com/cheerego/uci/app/cli/internal/messaging/shim/listwatch"
	"github.com/cheerego/uci/pkg/log"
	"github.com/mitchellh/go-homedir"
	"go.uber.org/zap"
	"path"
)

func init() {
	dir, _ := homedir.Dir()
	cli, err := log.Cli(log.DefaultLogLevel(), path.Join(dir, config.Name, fmt.Sprintf("%s.%s", config.Name, "log")))
	if err != nil {
		panic(any(err))
	}
	zap.ReplaceGlobals(cli)
}

func Execute() {
	internal.NewUci(listwatch.NewShimer()).Root().Execute()
}

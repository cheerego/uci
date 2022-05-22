package cli

import (
	"github.com/cheerego/uci/app/cli/internal/executor"
	"github.com/cheerego/uci/app/cli/internal/executor/shim/listwatch"
	"github.com/cheerego/uci/pkg/log"
	"github.com/mitchellh/go-homedir"
	"go.uber.org/zap"
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

func Execute() {
	executor.NewUci(listwatch.NewListWatch()).Root().Execute()
}

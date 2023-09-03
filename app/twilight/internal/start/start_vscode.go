package start

import (
	"fmt"
	"github.com/cheerego/uci/app/twilight/internal/runner"
	"github.com/cheerego/uci/app/twilight/internal/types"
	"github.com/cockroachdb/errors"
	"github.com/labstack/echo/v4"
	"go.uber.org/zap"
	"net/url"
)

func StartVsCode(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {
		cc := types.StartContextFromContext(c)
		taskName := cc.TaskName

		urlParser, err := url.Parse(cc.GitHttpUrl)
		if err != nil {
			return err
		}
		codeDir := fmt.Sprintf("/Users/crush/.uci/git/%s", cc.TaskName)
		script := fmt.Sprintf(`mkdir -p /Users/crush/.uci/git
git clone %s://%s:%s@%s%s %s

`, urlParser.Scheme, cc.GitUsername, cc.GitPassword, urlParser.Host, urlParser.Path, codeDir)
		gitCloneLog, err := runner.Exec(taskName, "127.0.0.1", 8081, script, 100)
		if err != nil {
			return errors.WithMessage(err, gitCloneLog)
		}
		zap.L().Info("git clone log", zap.String("log", gitCloneLog))

		exec, err := runner.Exec(taskName, "127.0.0.1", 8081, fmt.Sprintf(`docker run --name %s -it -w /root/workspace -v %s:/root/workspace  -d code-server bash code-server . --auth=none --disable-update-check --disable-telemetry --disable-workspace-trust --bind-addr=0.0.0.0:8080`, taskName, codeDir), 10)
		if err != nil {
			return errors.WithMessage(err, exec)
		}
		return c.String(200, exec)
		//return next(c)
	}
}

package start

import (
	"fmt"
	"github.com/cheerego/uci/app/uci-master/internal/provider"
	"github.com/cheerego/uci/app/uci-master/internal/runner"
	"github.com/cheerego/uci/app/uci-master/internal/types"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cockroachdb/errors"
	"github.com/labstack/echo/v4"
	"go.uber.org/zap"
	"net/url"
	"strings"
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
		gitCloneLog, err := runner.Exec(taskName, cc.Runner.Host, cc.Runner.Port, script, 100)
		if err != nil {
			return errors.WithMessage(err, gitCloneLog)
		}
		log.Info("git clone log", zap.String("log", gitCloneLog))

		exec, err := runner.Exec(taskName, cc.Runner.Host, cc.Runner.Port, fmt.Sprintf(`docker run --name %s -it -w /root/workspace -v %s:/root/workspace  -d code-server bash code-server . --auth=none --disable-update-check --disable-telemetry --disable-workspace-trust --bind-addr=:8080`, taskName, codeDir), 10)
		if err != nil {
			return errors.WithMessage(err, exec)
		}

		s, err := runner.Exec(taskName, cc.Runner.Host, cc.Runner.Port, fmt.Sprintf("docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' %s", taskName), 10)
		if err != nil {
			return errors.WithMessage(err, "获取容器 IP 报错")
		}

		containerIP := strings.ReplaceAll(s, "\n", "")
		_, err = provider.Redis().Set(c.Request().Context(), fmt.Sprintf("%s_container_ip", taskName), containerIP, 0).Result()
		_, err = provider.Redis().Set(c.Request().Context(), fmt.Sprintf("%s_runner_addr", taskName), cc.Runner.Addr(), 0).Result()

		if err != nil {
			return err
		}
		return c.JSON(200, echo.Map{
			"taskName":    taskName,
			"containerIP": containerIP,
		})
		//return next(c)
	}
}

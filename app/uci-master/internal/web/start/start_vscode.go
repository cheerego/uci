package start

import (
	"fmt"
	"github.com/cheerego/uci/app/uci-master/internal/provider"
	"github.com/cheerego/uci/app/uci-master/internal/service"
	"github.com/cheerego/uci/app/uci-master/internal/types"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cockroachdb/errors"
	"github.com/labstack/echo/v4"
	"go.uber.org/zap"
	"strings"
)

func StartVsCode(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {
		cc := types.StartContextFromContext(c)
		taskName := cc.TaskName
		log.Info("task envs", zap.String("taskName", cc.TaskName), zap.String("repoName", cc.GitRepoName), zap.Any("envs", cc.Envs))

		containerName := fmt.Sprintf("%s-git-clone-cow", taskName)

		join := strings.Join([]string{
			"docker run -d --rm",
			fmt.Sprintf("--name %s", containerName),
			fmt.Sprintf("-v /root/.uci/git/persistence/%s:/git/cow/%s/lower", cc.GitRepoName, taskName),
			fmt.Sprintf("-v /root/.uci/git/workspace/%s:/git/cow/%s/merged:rshared", cc.TaskName, taskName),
			cc.Envs.ToDocker(),
			"--privileged=true",
			"git-clone-cow:latest",
			"sleep 2000",
		}, " ")

		log.Infof("git-clone-cow taskName %s script %s", taskName, join)
		runCowLong, err := service.Services.RunnerClientService.Exec(
			c.Request().Context(),
			taskName,
			cc.Runner.Host,
			cc.Runner.Port,
			join, 100)
		if err != nil {
			return errors.WithMessage(err, runCowLong)
		}
		log.Info("run cow log", zap.String("log", runCowLong))

		runCloneLog, err := service.Services.RunnerClientService.Exec(c.Request().Context(),
			taskName,
			cc.Runner.Host,
			cc.Runner.Port,
			strings.Join([]string{
				"docker exec -i",
				containerName,
				"/app/entrypoint.sh",
			}, " "),
			1000)
		if err != nil {
			return errors.WithMessage(err, runCloneLog)
		}

		exec, err := service.Services.RunnerClientService.Exec(c.Request().Context(), taskName, cc.Runner.Host, cc.Runner.Port,
			strings.Join([]string{
				"docker run --name",
				taskName,
				"-d -it -w /root/workspace",
				"-v ",
				fmt.Sprintf("%s:/root/workspace", fmt.Sprintf("/root/.uci/git/workspace/%s", taskName)),
				"code-server:latest",
				"bash code-server . --auth=none --disable-update-check --disable-telemetry --disable-workspace-trust --bind-addr=0.0.0.0:8080",
			}, " "),
			10)
		if err != nil {
			return errors.WithMessage(err, exec)
		}

		s, err := service.Services.RunnerClientService.Exec(c.Request().Context(), taskName, cc.Runner.Host, cc.Runner.Port, fmt.Sprintf("docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' %s", taskName), 10)
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

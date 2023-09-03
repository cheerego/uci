package start

import (
	"fmt"
	"github.com/cockroachdb/errors"
	"github.com/labstack/echo/v4"
	"go.uber.org/zap"
	"io/ioutil"
	"net/http"
	"net/url"
	"strconv"
)

func StartVsCode(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {
		cc := c.(*StartContext)

		urlParser, err := url.Parse(cc.GitHttpUrl)
		if err != nil {
			return err
		}
		codeDir := fmt.Sprintf("/Users/crush/.uci/git/%s", cc.TaskName)
		script := fmt.Sprintf(`mkdir -p /Users/crush/.uci/git
git clone %s://%s:%s@%s%s %s

`, urlParser.Scheme, cc.GitUsername, cc.GitPassword, urlParser.Host, urlParser.Path, codeDir)
		gitCloneLog, err := RunnerExec("127.0.0.1", 8081, script, 100)
		if err != nil {
			return errors.WithMessage(err, gitCloneLog)
		}
		zap.L().Info("git clone log", zap.String("log", gitCloneLog))

		exec, err := RunnerExec("127.0.0.1", 8081, fmt.Sprintf(`docker run -it -w /root/workspace -v %s:/root/workspace -p 8083:8083 -d code-server bash code-server . --auth=none --disable-update-check --disable-telemetry --disable-workspace-trust --bind-addr=0.0.0.0:8083`, codeDir), 10)
		if err != nil {
			return errors.WithMessage(err, exec)
		}
		return c.String(200, exec)
		//return next(c)
	}
}
func RunnerExec(ip string, port int, shell string, timeoutSecond int) (string, error) {
	client := http.DefaultClient

	req, _ := http.NewRequest("GET", fmt.Sprintf("http://%s:%d/runner/exec", ip, port), nil)

	q := req.URL.Query()
	q.Add("script", shell)
	q.Add("timeout", strconv.Itoa(timeoutSecond))
	req.URL.RawQuery = q.Encode()
	do, err := client.Do(req)
	if err != nil {
		return "", err
	}
	defer do.Body.Close()

	all, err := ioutil.ReadAll(do.Body)
	if err != nil {
		return "", err
	}

	var returnErr error = nil
	if do.StatusCode != 200 {
		returnErr = errors.New("dispatch runner status code != 200")
	}
	return string(all), returnErr
}

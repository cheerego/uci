package start

import (
	"fmt"
	"github.com/cockroachdb/errors"
	"github.com/labstack/echo/v4"
	"io/ioutil"
	"net/http"
	"strconv"
)

func StartVsCode(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {
		exec, err := RunnerExec("127.0.0.1", 8081, "docker run -it -w /root/workspace -p 8083:8083 -d code-server bash code-server . --auth=none --disable-update-check --disable-telemetry --disable-workspace-trust --bind-addr=0.0.0.0:8083", 10)
		if err != nil {
			return err
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

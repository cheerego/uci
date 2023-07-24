package route

import (
	"fmt"
	"github.com/cockroachdb/errors"
	"github.com/labstack/echo/v4"
	"io/ioutil"
	"net/http"
	"strconv"
)

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
		returnErr = errors.New("status code != 200")
	}
	return string(all), returnErr
}

func Routes(engine *echo.Echo) {
	engine.Any("/", func(c echo.Context) error {
		return c.String(200, "hello world")
	})
	engine.Any("/api/start", func(c echo.Context) error {
		exec, _ := RunnerExec("127.0.0.1", 8081, "docker run -d nginx", 10)
		return c.String(200, exec)
	})
	engine.Any("/web/*", func(c echo.Context) error {

		return nil
	})
}

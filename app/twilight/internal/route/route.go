package route

import (
	"crypto/tls"
	"fmt"
	"github.com/cockroachdb/errors"
	"github.com/elazarl/goproxy"
	"github.com/labstack/echo/v4"
	"github.com/samber/lo"
	"io/ioutil"
	"net/http"
	"net/url"
	"strconv"
	"strings"
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
	engine.Any("/api/start", func(c echo.Context) error {
		exec, _ := RunnerExec("127.0.0.1", 8081, "docker run -it -w /root/workspace -d code-server bash code-server . --auth=none --disable-update-check --disable-telemetry --disable-workspace-trust --bind-addr=0.0.0.0:8083", 10)
		return c.String(200, exec)
	})

	engine.Any("/a*", func(c echo.Context) error {
		return c.String(200, "/a/*")
	})

	engine.Any("/vscode/*", func(c echo.Context) error {
		scheme := "http"
		if c.IsWebSocket() {
			scheme = "ws"
		}
		httpAgent := func(r *http.Request) (*url.URL, error) {
			return url.Parse(fmt.Sprintf("%s://localhost:8081", "http"))
		}
		targetUrl, _ := url.Parse(fmt.Sprintf("%s://localhost:8083", scheme))

		proxy := goproxy.NewProxyHttpServer()

		proxy.Tr = &http.Transport{TLSClientConfig: &tls.Config{InsecureSkipVerify: true}, Proxy: httpAgent}

		req := c.Request()
		res := c.Response().Writer
		req.URL.Host = targetUrl.Host
		req.URL.Scheme = targetUrl.Scheme
		split := lo.Filter(strings.Split(req.URL.Path, "/"), func(item string, index int) bool {
			return item != ""
		})

		join3 := "/" + strings.Join([]string{"vscode", split[1], "run"}, "/")
		if strings.HasPrefix(req.URL.Path, join3) {
			if len(split) == 3 {
				req.URL.Path = "/"
			} else {
				req.URL.Path = "/" + strings.Join(split[3:], "/")
			}
		} else {
			req.URL.Path = "/" + strings.Join(split[2:], "/")
		}

		proxy.ServeHTTP(res, req)
		return nil
	})
}

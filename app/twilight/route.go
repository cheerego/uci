package twilight

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

	engine.Any("/vscode/*", func(c echo.Context) error {
		split := lo.Filter(strings.Split(c.Request().URL.Path, "/"), func(item string, index int) bool {
			return item != ""
		})

		rootPath := fmt.Sprintf("/vscode/%s", split[1])
		if c.Request().URL.Path == rootPath {
			return c.Redirect(302, rootPath+"/")
		}
		manifestPath := fmt.Sprintf("%s/%s", rootPath, "manifest.json")
		if c.Request().URL.Path == manifestPath {
			return c.String(200, `{
  "name": "hkn code-server",
  "short_name": "hkn code-server",
  "start_url": ".",
  "display": "fullscreen",
  "description": "Run Code on a remote server.",
  "icons": [
    {
      "src": "./_static/src/browser/media/pwa-icon-192.png",
      "type": "image/png",
      "sizes": "192x192"
    },
    {
      "src": "./_static/src/browser/media/pwa-icon-512.png",
      "type": "image/png",
      "sizes": "512x512"
    }
  ]
}`)
		}

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

		//join3 := "/" + strings.Join([]string{"vscode", split[1], "run"}, "/")
		req.URL.Path = "/" + strings.Join(split[2:], "/")

		proxy.ServeHTTP(res, req)
		return nil
	})
}

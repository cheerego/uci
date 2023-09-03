package vscode

import (
	"crypto/tls"
	"fmt"
	"github.com/cheerego/uci/pkg/types"
	"github.com/elazarl/goproxy"
	"github.com/labstack/echo/v4"
	"github.com/samber/lo"
	"net/http"
	"net/url"
	"strconv"
	"strings"
)

func VsCode(c echo.Context) error {
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
	targetUrl, _ := url.Parse(fmt.Sprintf("%s://172.10.0.3:8080", scheme))

	proxy := goproxy.NewProxyHttpServer()

	proxy.Tr = &http.Transport{TLSClientConfig: &tls.Config{InsecureSkipVerify: true}, Proxy: httpAgent}

	req := c.Request()
	res := c.Response().Writer
	req.URL.Host = targetUrl.Host
	req.URL.Scheme = targetUrl.Scheme
	header := req.Header
	header.Set(types.VSCODE_TASK_NAME_HEADER, "")
	header.Set(types.VSCODE_TASK_IP_HEADER, "172.10.0.3")
	header.Set(types.VSCODE_PORT_HEADER, strconv.Itoa(types.VSCODE_PORT))

	req.Header = header

	//join3 := "/" + strings.Join([]string{"vscode", split[1], "run"}, "/")
	req.URL.Path = "/" + strings.Join(split[2:], "/")

	proxy.ServeHTTP(res, req)
	return nil
}

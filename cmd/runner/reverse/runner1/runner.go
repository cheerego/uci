package main

import (
	"github.com/cheerego/uci/pkg/http"
	"github.com/labstack/echo/v4"
	"net/http/httputil"
	"net/url"
)

func main() {

	httpServer := http.NewEcho()

	httpServer.GET("/", func(c echo.Context) error {
		u, _ := url.Parse("http://127.0.0.1:9091/")
		httputil.NewSingleHostReverseProxy(u)
		proxy := httputil.NewSingleHostReverseProxy(u)
		proxy.ServeHTTP(c.Response(), c.Request())
		c.SetResponse(c.Response())
		return nil

	})

	httpServer.Start(":8081")

	//proxy.ServeHTTP(w, r)

}

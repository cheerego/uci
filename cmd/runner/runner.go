package main

import (
	"crypto/tls"
	http2 "github.com/cheerego/uci/pkg/http"
	"github.com/elazarl/goproxy"
	"github.com/labstack/echo/v4"
	"net/http"
	"net/url"
)

func main() {
	httpServer := http2.NewEcho()

	targetUrl, _ := url.Parse("ws://localhost:9091")

	httpAgent := func(r *http.Request) (*url.URL, error) {
		return url.Parse("http://localhost:9091")
	}

	httpServer.GET("/console", func(c echo.Context) error {

		return c.HTML(200, `<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>WebSocket</title>
</head>
<body>
    <h1>Echo Test</h1>
    <input type="text" id="sendTxt">
    <button id="sendBtn">发送</button>
    <div id="recv"></div>
    <script type="text/javascript">
        var websocket = new WebSocket("ws://127.0.0.1:8081/ws");
        websocket.onopen = function(){
            console.log("websocket open");
            document.getElementById("recv").innerHTML = "Connected";
        }
        websocket.inclose = function(){
            console.log('websocket close');
        }
        websocket.onmessage = function(e){
            console.log(e.data);
            document.getElementById("recv").innerHTML = e.data;
        }
        document.getElementById("sendBtn").onclick = function(){
            var txt = document.getElementById("sendTxt").value;
			console.log(txt);	
            websocket.send(txt);
        }

    </script>
</body>
</html>`)
	})

	httpServer.GET("/*", func(c echo.Context) error {
		proxy := goproxy.NewProxyHttpServer()
		proxy.Tr = &http.Transport{TLSClientConfig: &tls.Config{InsecureSkipVerify: true}, Proxy: httpAgent}

		req := c.Request()
		res := c.Response().Writer

		//Update the headers to allow for SSL redirection
		req.Host = targetUrl.Host
		req.URL.Host = targetUrl.Host
		req.URL.Scheme = targetUrl.Scheme
		proxy.ServeHTTP(res, req)
		return nil
	})

	httpServer.Start(":8081")

}

package route

import (
	"crypto/tls"
	"fmt"
	"github.com/cheerego/uci/pkg/types"
	"github.com/elazarl/goproxy"
	"github.com/labstack/echo/v4"
	"net/http"
	"net/url"
)

//func () {
//	httpAgent := func(r *http.Request) (*url.URL, error) {
//		return url.Parse("http://localhost:9091")
//	}
//
//	engine.GET("/console", func(c echo.Context) error {
//
//		return c.HTML(200, `<!DOCTYPE html>
//<html lang="en">
//<head>
//    <meta charset="UTF-8">
//    <title>WebSocket</title>
//</head>
//<body>
//    <h1>Echo Test</h1>
//    <input type="text" id="sendTxt">
//    <button id="sendBtn">发送</button>
//    <div id="recv"></div>
//    <script type="text/javascript">
//        var websocket = new WebSocket("ws://127.0.0.1:8081/ws");
//        websocket.onopen = function(){
//            console.z("websocket open");
//            document.getElementById("recv").innerHTML = "Connected";
//        }
//        websocket.inclose = function(){
//            console.z('websocket close');
//        }
//        websocket.onmessage = function(e){
//            console.z(e.data);
//            document.getElementById("recv").innerHTML = e.data;
//        }
//        document.getElementById("sendBtn").onclick = function(){
//            var txt = document.getElementById("sendTxt").value;
//			console.z(txt);
//            websocket.send(txt);
//        }
//
//    </script>
//</body>
//</html>`)
//	})
//
//	engine.GET("/*", func(c echo.Context) error {
//		proxy := goproxy.NewProxyHttpServer()
//		proxy.Tr = &http.Transport{TLSClientConfig: &tls.Config{InsecureSkipVerify: true}, Proxy: httpAgent}
//
//		req := c.Request()
//		res := c.Response().Writer
//
//		//Update the headers to allow for SSL redirection
//		req.Host = targetUrl.Host
//		req.URL.Host = targetUrl.Host
//		req.URL.Scheme = targetUrl.Scheme
//		proxy.ServeHTTP(res, req)
//		return nil
//	})

//}

func Proxy(c echo.Context) error {
	scheme := "http"
	if c.IsWebSocket() {
		scheme = "ws"
	}
	ip := c.Request().Header.Get(types.VSCODE_TASK_IP_HEADER)
	port := c.Request().Header.Get(types.VSCODE_PORT_HEADER)
	targetUrl, _ := url.Parse(fmt.Sprintf("%s://%s:%s", scheme, ip, port))

	proxy := goproxy.NewProxyHttpServer()

	proxy.Tr = &http.Transport{TLSClientConfig: &tls.Config{InsecureSkipVerify: true}}

	req := c.Request()
	res := c.Response().Writer

	//Update the headers to allow for SSL redirection
	req.URL.Host = targetUrl.Host
	req.URL.Scheme = targetUrl.Scheme
	proxy.ServeHTTP(res, req)
	return nil
}

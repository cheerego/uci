package route

import (
	"fmt"
	"github.com/labstack/echo/v4"
	"gopkg.in/olahol/melody.v1"
)

func Routes(engine *echo.Echo) {
	engine.Any("/uci-uci-runner/exec", Exec)
	engine.Any("/*", Proxy)
	engine.GET("/console", func(c echo.Context) error {
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
	WS(engine)
}

func WS(r *echo.Echo) {
	m := melody.New()

	r.GET("/ws", func(c echo.Context) error {
		return m.HandleRequest(c.Response().Writer, c.Request())
	})

	m.HandlePong(func(session *melody.Session) {

	})

	m.HandleConnect(func(session *melody.Session) {

	})
	m.HandleClose(func(session *melody.Session, i int, s string) error {
		return nil
	})
	m.HandleDisconnect(func(session *melody.Session) {

	})
	m.HandleSentMessage(func(session *melody.Session, bytes []byte) {

	})
	m.HandleMessage(func(s *melody.Session, msg []byte) {
		fmt.Println(string(msg))
	})
}

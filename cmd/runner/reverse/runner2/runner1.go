package main

import (
	"fmt"
	"github.com/cheerego/uci/pkg/http"
	"github.com/labstack/echo/v4"
	"gopkg.in/olahol/melody.v1"
)

func main() {

	httpServer := http.NewEcho()

	httpServer.GET("/", func(c echo.Context) error {
		return c.String(200, "hello world")

	})

	httpServer.GET("/123", func(c echo.Context) error {
		return c.String(200, "hello world")

	})

	WS(httpServer)

	httpServer.Start(":9091")

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

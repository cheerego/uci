package web

import (
	"github.com/labstack/echo/v4"
	"gopkg.in/olahol/melody.v1"
)

func WS(r *echo.Echo) {
	m := melody.New()

	r.GET("/uci/ws", func(c echo.Context) error {
		m.HandleRequest(c.Response().Writer, c.Request())
		return nil
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
		m.Broadcast(msg)
	})
}

package web

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/web/controller/messging"
	"github.com/labstack/echo/v4"
	"gopkg.in/olahol/melody.v1"
)

func Route(r *echo.Echo) {
	r.GET("/", func(c echo.Context) error {
		return c.String(200, "hello world")
	})
	r.GET("/message/:name/subscribe", messging.Subscribe)
	r.GET("/message/:name/publish", messging.Publish)

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

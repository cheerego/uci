package web

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/web/controller/index"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/web/controller/inner/workerflow"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/web/controller/messging"
	"github.com/go-playground/validator"
	"github.com/labstack/echo/v4"
	"gopkg.in/olahol/melody.v1"
	"net/http"
)

type RequestValidator struct {
	validator *validator.Validate
}

func NewRequestValidator() *RequestValidator {
	return &RequestValidator{validator: validator.New()}
}

func (cv *RequestValidator) Validate(i interface{}) error {
	if err := cv.validator.Struct(i); err != nil {
		// Optionally, you could return the error to give each route more control over the status code
		return echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}
	return nil
}

func Route(r *echo.Echo) {
	r.Validator = NewRequestValidator()
	r.GET("/", index.Index)
	api := r.Group("/api/v1")
	{
		api.GET("/message/:name/subscribe", messging.Subscribe)
		api.GET("/message/:name/publish", messging.Publish)
		api.GET("/message/subscribers", messging.Subscribers)
		api.POST("/inner/workerflow/trigger", workerflow.Trigger)
	}

	ws(r)
}

func ws(r *echo.Echo) {
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

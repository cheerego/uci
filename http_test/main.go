package main

import (
	"fmt"
	"github.com/cheerego/uci/pkg/http/middleware/ectx"
	"github.com/labstack/echo/v4"
)

func main() {
	e := echo.New()
	e.Use(ectx.ContextMiddleware)

	e.GET("/message/:clientId/subscribe", Subscribe)
	e.Start(":8001")
}

func Subscribe(c echo.Context) error {
	clientId := c.Param("clientId")
	watch := c.QueryParam("watch")
	c.Response().Header().Set(echo.HeaderContentType, echo.MIMEApplicationJSON)
	c.Response().Flush()

	if watch == "true" {
		var subscribe = make(chan string)
		defer func() {
			fmt.Printf("client %s subscribe cancel", clientId)
		}()
		header := c.Response().Header()
		header.Set("Transfer-Encoding", "chunked")

		c.Response().Flush()

		fmt.Println("client %s subscribe ing", clientId)
		fmt.Println("client %s subscribe success", clientId)
		for {
			select {
			case payload, ok := <-subscribe:
				if !ok {
					return nil
				}
				c.Logger().Info(payload)
				c.Response().Write([]byte(payload))
				c.Response().Flush()
			case <-c.Request().Context().Done():
				return nil
			}
		}
	}
	return nil
}

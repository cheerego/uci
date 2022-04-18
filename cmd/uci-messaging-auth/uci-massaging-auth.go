package main

import (
	"github.com/labstack/echo/v4"
)

func main() {
	r := echo.New()
	r.GET("/", func(c echo.Context) error {
		return c.String(200, "hello world")
	})
	r.Start(":8080") // listen and serve on 0.0.0.0:8080 (for windows "localhost:8080")
}

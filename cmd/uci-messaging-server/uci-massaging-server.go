package main

import (
	"fmt"
	"github.com/labstack/echo/v4"
	"net/http"
	"time"
)

func main() {
	r := echo.New()
	r.GET("/name", func(c echo.Context) error {

		header := c.Response().Header()
		header.Set("Transfer-Encoding", "chunked")
		header.Set("Content-Type", "text/html")
		c.Response().WriteHeader(http.StatusOK)

		c.Response().Write([]byte(`
			<html>
					<body>
		`))
		c.Response().Flush()

		for i := 0; i < 100; i++ {
			c.Response().Write([]byte(fmt.Sprintf(`
				<h1>%d</h1>
			`, i)))
			c.Response().Flush()
			time.Sleep(time.Duration(1) * time.Second)
		}
		c.Response().Write([]byte(`
			
					</body>
			</html>
		`))
		c.Response().Flush()

		return nil
	})
	r.GET("/", func(c echo.Context) error {
		return c.String(200, "hello world")
	})
	r.Start(":8080") // listen and serve on 0.0.0.0:8080 (for windows "localhost:8080")
}

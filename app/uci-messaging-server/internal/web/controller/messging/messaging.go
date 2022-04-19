package messging

import (
	"fmt"
	"github.com/cheerego/uci/app/uci-messaging-server/internal/shim/watcher"
	"github.com/labstack/echo/v4"
	"net/http"
)

func Subscribe(c echo.Context) error {
	name := c.Param("name")
	watch := c.QueryParam("watch")
	fmt.Println(name, watch)
	defer func() {
		watcher.Unsubscribe(name)
	}()
	if watch == "true" {
		header := c.Response().Header()
		header.Set("Transfer-Encoding", "chunked")
		header.Set("Content-Type", "text/html")
		c.Response().WriteHeader(http.StatusOK)
		c.Response().Flush()

		subscribe, err := watcher.Subscribe(name)
		if err != nil {
			c.Error(err)
			return nil
		}
		for str := range subscribe {
			c.Logger().Info(str)
			c.Response().Write([]byte(fmt.Sprintf("%s,%s", str, "<\br>")))
			c.Response().Flush()
		}
		return nil
	}

	c.String(200, "message list")
	return nil

}

func Publish(c echo.Context) error {
	payload := c.QueryParam("payload")
	name := c.Param("name")
	if ch, load := watcher.Load(name); load {
		ch.(chan string) <- payload
		return c.String(200, "ok")
	} else {
		return c.String(200, "no subscribe")
	}
}

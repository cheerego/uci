package main

import (
	"errors"
	"fmt"
	"github.com/labstack/echo/v4"
	"net/http"
	"sync"
)

type Listeners struct {
	Workers map[string]chan string
	sync.Mutex
}

func NewListeners() *Listeners {
	return &Listeners{
		Workers: make(map[string]chan string),
	}
}

func (l *Listeners) Subscribe(name string) (chan string, error) {
	l.Lock()
	defer l.Unlock()

	if _, ok := l.Workers[name]; ok {
		return nil, errors.New("重复订阅")
	}
	ch := make(chan string, 10)
	l.Workers[name] = ch
	return ch, nil
}

func (l *Listeners) Unsubscribe(name string) {
	l.Lock()
	defer l.Unlock()
	if ch, ok := l.Workers[name]; ok {
		close(ch)
		delete(l.Workers, name)
	}
}
func main() {
	listeners := NewListeners()

	r := echo.New()

	r.GET("/message/:name", func(c echo.Context) error {
		name := c.Param("name")
		watch := c.QueryParam("watch")
		fmt.Println(name, watch)
		defer func() {
			listeners.Unsubscribe(name)
		}()
		if watch == "true" {
			header := c.Response().Header()
			header.Set("Transfer-Encoding", "chunked")
			header.Set("Content-Type", "text/html")
			c.Response().WriteHeader(http.StatusOK)
			c.Response().Flush()

			subscribe, err := listeners.Subscribe(name)
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

	})
	r.GET("/", func(c echo.Context) error {
		return c.String(200, "hello world")
	})
	r.GET("/publish/:name/message", func(c echo.Context) error {
		payload := c.QueryParam("payload")
		name := c.Param("name")
		if ch, ok := listeners.Workers[name]; ok {
			ch <- payload
			return c.String(200, "ok")
		} else {
			return c.String(200, "no subscribe")
		}
	})

	r.GET("/worker", func(c echo.Context) error {
		keys := make([]string, 0)
		for key, _ := range listeners.Workers {
			keys = append(keys, key)
		}
		return c.JSON(200, keys)
	})

	r.Start(":8080") // listen and serve on 0.0.0.0:8080 (for windows "localhost:8080")
}

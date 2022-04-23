package shim

import (
	"bufio"
	"fmt"
	"github.com/go-resty/resty/v2"
	"io"
	"net/http"
	"time"
)

type ListWatch struct {
	BaseShimer
	resty *resty.Client
}

func NewListWatch() *ListWatch {
	client := resty.NewWithClient(&http.Client{
		Transport:     http.DefaultTransport,
		CheckRedirect: nil,
		Jar:           nil,
		Timeout:       100 * time.Second,
	})
	return &ListWatch{
		resty:      client,
		BaseShimer: BaseShimer{},
	}
}

var _ Shimer = (*ListWatch)(nil)

func (l *ListWatch) StartListener() error {
	for {
		err := l.Watching()
		fmt.Print(err)
	}
}

func (l *ListWatch) Watching() error {
	resp, err := http.Get("http://localhost:8080/describe/1/message?watch=true")
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	reader := bufio.NewReader(resp.Body)
	for {
		line, err := reader.ReadString('\n')
		if len(line) > 0 {
			fmt.Print(line)
		}
		if err == io.EOF {
			break
		}
		if err != nil {
			return err
		}
	}
	return nil
}

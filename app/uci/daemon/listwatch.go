package daemon

import (
	"bufio"
	"fmt"
	"github.com/go-resty/resty/v2"
	"io"
	"log"
	"net/http"
	"time"
)

type ListWatch struct {
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
		resty: client,
	}
}

var _ Daemoner = (*ListWatch)(nil)

func (l *ListWatch) StartListener() error {

	resp, err := http.Get("http://localhost:8080/describe/1/message?watch=true")
	if err != nil {
		log.Fatal(err)
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
			log.Fatal(err)
		}
	}
	return nil
}

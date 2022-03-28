package main

import (
	"bufio"
	"fmt"
	"io"
	"log"
	"net/http"
)

func main() {

	//client := &http.Client{
	//	Transport:     http.DefaultTransport,
	//	CheckRedirect: nil,
	//	Jar:           nil,
	//	Timeout:       100 * time.Second,
	//}

	resp, err := http.Get("http://localhost:8080/name")
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
}

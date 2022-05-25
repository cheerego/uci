package main

import (
	"log"
	"time"
)

func main() {
	defer func() {
		log.Println("123", recover())
	}()
	go func() {
		time.Sleep(2 * time.Second)
		panic(123)
	}()

	time.Sleep(10 * time.Second)

}

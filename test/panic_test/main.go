package main

import panic2 "github.com/cheerego/uci/test/panic_test/pkg/panic"

func init() {
	panic2.InitPanicFile()
}

func main() {
	panic(123)

}

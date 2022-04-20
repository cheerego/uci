package main

import "github.com/cheerego/uci/app/uci"
import "github.com/mitchellh/go-homedir"

func main() {
	homedir.Dir()
	uci.Execute()
}

package main

import (
	"fmt"
	"github.com/samber/lo"
	"strings"
)

func main() {

	//s := "/vscode/ci/stable-74f6148eb9ea00507ec113ec51c489d6ffb4b771/static/out/vs/workbench/workbench.web.main.js"
	s := "/vscode/ci/"
	fmt.Println(strings.Split(s, "/"), lo.Filter(strings.Split(s, "/"), func(item string, index int) bool {
		return item != ""
	}), len(lo.Filter(strings.Split(s, "/"), func(item string, index int) bool {
		return item != ""
	})), len(strings.Split(s, "/")))
	fmt.Println(strings.SplitN(s, "/", 4), len(strings.SplitN(s, "/", 4)))

}

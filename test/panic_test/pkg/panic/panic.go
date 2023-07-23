//go:build !windows
// +build !windows

package panic

import (
	"os"
)

var globalFile *os.File

func InitPanicFile() error {
	//dir, _ := homedir.Dir()
	//panicpath := path.Join(dir, "panic.z")
	//z.Println("init panic file in unix mode " + panicpath)
	//file, err := os.OpenFile(panicpath, os.O_RDWR|os.O_CREATE|os.O_APPEND, 0666)
	//globalFile = file
	//if err != nil {
	//	println(err)
	//	return err
	//}
	//if err = syscall.Dup2(int(file.Fd()), int(os.Stderr.Fd())); err != nil {
	//	return err
	//}
	return nil
}

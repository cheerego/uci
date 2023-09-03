//go:build windows
// +build windows

package panic

import (
	"fmt"
	"github.com/mitchellh/go-homedir"
	"os"
	"path"
	"syscall"
)

const (
	kernel32dll = "kernel32.dll"
)

var globalFile *os.File

func InitPanicFile() error {
	dir, _ := homedir.Dir()
	panicpath := path.Join(dir, "panic.log")
	fmt.Println("init panic file in windows mode " + panicpath)
	file, err := os.OpenFile(panicpath, os.O_CREATE|os.O_APPEND, 0666)
	globalFile = file
	if err != nil {
		return err
	}
	kernel32 := syscall.NewLazyDLL(kernel32dll)
	setStdHandle := kernel32.NewProc("SetStdHandle")
	sh := syscall.STD_ERROR_HANDLE
	v, _, err := setStdHandle.Call(uintptr(sh), uintptr(file.Fd()))
	if v == 0 {
		return err
	}
	return nil
}

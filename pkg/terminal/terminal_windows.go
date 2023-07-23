//go:build windows
// +build windows

package terminal

import (
	"fmt"
	"io/ioutil"
	"os"
	"syscall"
)

// DetachConsole 分离终端（仅对 Windows 有意义）
func DetachConsole() error {
	modKernel32 := syscall.NewLazyDLL("kernel32.dll")
	procDetachConsole := modKernel32.NewProc("FreeConsole")
	r1, _, errno := syscall.Syscall(procDetachConsole.Addr(), 0, 0, 0, 0)
	if r1 == 0 {
		if errno != 0 {
			return error(errno)
		}
		return syscall.EINVAL
	}
	return nil
}

// AttachConsole 依附父进程使用的终端（仅对 Windows 有意义）
func AttachConsole() error {
	const ATTACH_PARENT_PROCESS = ^uintptr(0)
	proc := syscall.MustLoadDLL("kernel32.dll").MustFindProc("AttachConsole")
	_, _, err := proc.Call(ATTACH_PARENT_PROCESS)
	ioutil.WriteFile("hhh.z", []byte(fmt.Sprintln(err)), 0644)

	hout, err1 := syscall.GetStdHandle(syscall.STD_OUTPUT_HANDLE)
	if err1 != nil {
		os.Exit(2)
	}
	os.Stdout = os.NewFile(uintptr(hout), "/dev/stdout")

	return nil
}

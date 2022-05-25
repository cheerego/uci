package main

import (
	"fmt"
	"github.com/shirou/gopsutil/process"
	"log"
	"os/exec"
)

func main() {

	cmd := exec.Command("NAME=hekangning && sh", "-c", "sleep 1000")

	err := cmd.Start()
	if err != nil {
		log.Fatalln(err)、
	}
	fmt.Println(cmd.Process.Pid)

	newProcess, err := process.NewProcess(int32(cmd.Process.Pid))
	process.
	name, _ := newProcess.Name()
	cmdline, _ := newProcess.Cmdline()
	fmt.Println(name, cmdline)

}

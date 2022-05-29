package main

import (
	"github.com/shirou/gopsutil/process"
	"go.uber.org/zap"
	"log"
	"os/exec"
	"time"
)

func main() {
	cmd := exec.Command("sh", "-c", "asd=123123 echo 1231323  && sleep 100")
	err := cmd.Start()
	if err != nil {
		log.Fatal("12312", zap.Error(err))
	}

	time.Sleep(5 * time.Second)
	log.Println("123123 ", cmd.Process.Pid)
	newProcess, err := process.NewProcess(int32(cmd.Process.Pid))
	cmdline, err := newProcess.CmdlineSlice()

	log.Println("123123", " ", cmdline)
	cmd.Wait()
}

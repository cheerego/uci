package signal

import (
	"os"
	"os/signal"
	"syscall"
)

func KillSignal() <-chan os.Signal {
	c := make(chan os.Signal)
	signal.Notify(c, os.Interrupt, syscall.SIGTERM, os.Kill)
	return c
}

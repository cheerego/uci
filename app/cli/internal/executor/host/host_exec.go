package host

import "os/exec"

type HostExec struct {
	*exec.Cmd
}

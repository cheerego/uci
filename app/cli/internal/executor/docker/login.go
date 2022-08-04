package docker

import (
	"context"
	"fmt"
	"github.com/docker/distribution/reference"
	"io"
	"os/exec"
)

func Login(stopCtx context.Context, host string, username string, password string, w io.Writer) error {
	named, err := reference.ParseNormalizedNamed(host)
	if err != nil {
		return err
	}
	domain := reference.Domain(named)
	if domain == "docker.io" {
		domain = ""
	}

	cmd := exec.CommandContext(stopCtx, "bash", "-c", fmt.Sprintf("echo %s | docker login --username %s --password-stdin %s", username, password, domain))
	cmd.Stdout = w
	cmd.Stderr = w

	err = cmd.Start()
	if err != nil {
		return err
	}
	return cmd.Wait()
}

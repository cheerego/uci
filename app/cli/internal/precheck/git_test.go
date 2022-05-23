package precheck

import (
	"os/exec"
	"testing"
)

func TestGit(t *testing.T) {

	cmd := exec.Command("git", "version23123")
	output, err := cmd.CombinedOutput()
	t.Log(string(output))
	t.Log(err)

}

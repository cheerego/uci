package precheck

import (
	"github.com/cheerego/uci/pkg/z"
	"os/exec"
	"strings"
)

//https://github.com/actions/runner/blob/main/src/Runner.Listener/Checks/GitCheck.cs

type Git struct {
}

func NewGit() *Git {
	return &Git{}
}

var _ PreCheck = (*Git)(nil)

func (g Git) CheckDescription() string {
	return "Check Git CLI version"
}

func (g Git) RunCheck() error {
	_, err := exec.LookPath("git")

	if err != nil {
		z.S().Infof("***************************************************************************************************************")
		z.S().Infof("****  %s                                                                                                   ", g.CheckDescription())
		z.S().Infof("***************************************************************************************************************")
		z.S().Infof("****                                                                                                       ****")
		z.S().Infof("****    Can't verify git since git is not install                                                                               ")
		z.S().Infof("****                                                                                                       ****")
		z.S().Infof("***************************************************************************************************************")
		return err
	}

	cmd := exec.Command("git", "version")
	output, err := cmd.CombinedOutput()

	if err != nil {
		z.S().Infof("***************************************************************************************************************")
		z.S().Infof("****  %s                                                                                                   ", g.CheckDescription())
		z.S().Infof("***************************************************************************************************************")
		z.S().Infof("****                                                                                                       ****")
		z.S().Infof("****    Can't verify git since `git version` exec failed!                                                                               ")
		z.S().Infof("****    err: %s outout: %s                                                                              ", err.Error(), strings.Trim(string(output), "\n"))
		z.S().Infof("****                                                                                                       ****")
		z.S().Infof("***************************************************************************************************************")
		return err
	}

	return nil
}

func (g Git) HelpLink() string {
	//TODO implement me
	panic("implement me")
}

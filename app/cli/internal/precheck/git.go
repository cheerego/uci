package precheck

import (
	"github.com/cheerego/uci/pkg/log"
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
		log.Infof("***************************************************************************************************************")
		log.Infof("****  %s                                                                                                   ", g.CheckDescription())
		log.Infof("***************************************************************************************************************")
		log.Infof("****                                                                                                       ****")
		log.Infof("****    Can't verify git since git is not install                                                                               ")
		log.Infof("****                                                                                                       ****")
		log.Infof("***************************************************************************************************************")
		return err
	}

	cmd := exec.Command("git", "version")
	output, err := cmd.CombinedOutput()

	if err != nil {
		log.Infof("***************************************************************************************************************")
		log.Infof("****  %s                                                                                                   ", g.CheckDescription())
		log.Infof("***************************************************************************************************************")
		log.Infof("****                                                                                                       ****")
		log.Infof("****    Can't verify git since `git version` exec failed!                                                                               ")
		log.Infof("****    err: %s outout: %s                                                                              ", err.Error(), strings.Trim(string(output), "\n"))
		log.Infof("****                                                                                                       ****")
		log.Infof("***************************************************************************************************************")
		return err
	}

	return nil
}

func (g Git) HelpLink() string {
	//TODO implement me
	panic("implement me")
}

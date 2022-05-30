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
		log.S().Infof("***************************************************************************************************************")
		log.S().Infof("****  %s                                                                                                   ", g.CheckDescription())
		log.S().Infof("***************************************************************************************************************")
		log.S().Infof("****                                                                                                       ****")
		log.S().Infof("****    Can't verify git since git is not install                                                                               ")
		log.S().Infof("****                                                                                                       ****")
		log.S().Infof("***************************************************************************************************************")
		return err
	}

	cmd := exec.Command("git", "version")
	output, err := cmd.CombinedOutput()

	if err != nil {
		log.S().Infof("***************************************************************************************************************")
		log.S().Infof("****  %s                                                                                                   ", g.CheckDescription())
		log.S().Infof("***************************************************************************************************************")
		log.S().Infof("****                                                                                                       ****")
		log.S().Infof("****    Can't verify git since `git version` exec failed!                                                                               ")
		log.S().Infof("****    err: %s outout: %s                                                                              ", err.Error(), strings.Trim(string(output), "\n"))
		log.S().Infof("****                                                                                                       ****")
		log.S().Infof("***************************************************************************************************************")
		return err
	}

	return nil
}

func (g Git) HelpLink() string {
	//TODO implement me
	panic("implement me")
}

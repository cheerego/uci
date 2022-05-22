package precheck

//https://github.com/actions/runner/blob/main/src/Runner.Listener/Checks/GitCheck.cs

type Git struct {
}

var _ PreCheck = (*Git)(nil)

func (g *Git) CheckName() string {
	return "Git CLI"
}

func (g *Git) CheckDescription() string {
	panic("Check if the Git CLI can execute")
}

func (g *Git) CheckLog() string {
	panic("implement me")
}

func (g *Git) HelpLink() string {
	return "https://git-scm.com/"
}

func (g *Git) RunCheck() error {
	//path, err := exec.LookPath("git")
	//if err != nil {
	//
	//}
	return nil
}

package precheck

type Dns struct {
}

var _ PreCheck = (*Dns)(nil)

func (d Dns) CheckName() string {
	panic("implement me")
}

func (d Dns) CheckDescription() string {
	panic("implement me")
}

func (d Dns) CheckLog() string {
	panic("implement me")
}

func (d Dns) HelpLink() string {
	panic("implement me")
}

func (d Dns) RunCheck() error {
	panic("implement me")
}

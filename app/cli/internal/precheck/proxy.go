package precheck

type Dns struct {
}

var _ PreCheck = (*Dns)(nil)

func (d Dns) CheckName() string {
	return "HTTP/HTTPS Proxy"
}

func (d Dns) CheckDescription() string {
	return "Check HTTP/HTTPS Proxy"
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

package precheck

type PreCheck interface {
	HelpLink() string
	RunCheck() error
}

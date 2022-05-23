package precheck

type PreCheck interface {
	CheckName() string
	CheckDescription() string
	CheckLog() string
	HelpLink() string
	RunCheck() error
}

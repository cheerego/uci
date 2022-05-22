package precheck

import "golang.org/x/net/http/httpproxy"

type PreCheck interface {
	CheckName() string
	CheckDescription() string
	CheckLog() string
	HelpLink() string
	RunCheck() error
}

func CheckDns() {

}

var ProxyPreCheck = NewPreCheck(
	"Proxy",
	"Check Http Proxy",
)

func CheckProxy() *httpproxy.Config {
	return httpproxy.FromEnvironment()
}

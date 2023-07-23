package precheck

import (
	"github.com/cheerego/uci/pkg/z"
	"golang.org/x/net/http/httpproxy"
)

type Proxy struct {
}

func NewProxy() *Proxy {
	return &Proxy{}
}

var _ PreCheck = (*Proxy)(nil)

func (d Proxy) CheckName() string {
	return "HTTP/HTTPS Proxy"
}

func (d Proxy) CheckDescription() string {
	return "Check HTTP/HTTPS Proxy"
}

func (d Proxy) RunCheck() error {
	config := httpproxy.FromEnvironment()
	if config.HTTPProxy != "" || config.HTTPSProxy != "" {
		z.S().Infof("***************************************************************************************************************")
		z.S().Infof("****  %s                                                                                                   ", d.CheckDescription())
		z.S().Infof("***************************************************************************************************************")
		z.S().Infof("****                                                                                                       ****")
		z.S().Infof("****     UCI Runner web proxy check                                                                                ")
		z.S().Infof("****     http_proxy: %s   https_proxy: %s   no_proxy: %s                                    ", config.HTTPProxy, config.HTTPSProxy, config.NoProxy)
		z.S().Infof("****                                                                                                       ****")
		z.S().Infof("***************************************************************************************************************")
	}
	return nil
}

func (d Proxy) HelpLink() string {
	return ""
}

package start

import (
	"fmt"
	"github.com/cheerego/uci/app/uci-master/internal/types"
	"github.com/cheerego/uci/pkg/log"
	"github.com/labstack/echo/v4"
	"github.com/samber/lo"
	"go.uber.org/zap"
	"net/url"
	"strings"
)

func GitCheck(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {
		cc := types.StartContextFromContext(c)
		if lo.IsNotEmpty(cc.StartRequest.GitRepoUrl) &&
			lo.IsNotEmpty(cc.StartRequest.GitRepoUsername) &&
			lo.IsNotEmpty(cc.StartRequest.GitRepoPassword) {
			cc.GitRepoUrl = cc.StartRequest.GitRepoUrl
			cc.GitRepoUsername = cc.StartRequest.GitRepoUsername
			cc.GitRepoPassword = cc.StartRequest.GitRepoPassword
			gitRepoUrlParse, err := url.Parse(cc.StartRequest.GitRepoUrl)
			if err != nil {
				return err
			}
			log.Info("hahahahaahah")
			cc.GitRepoName = strings.ReplaceAll(fmt.Sprintf("%s%s", gitRepoUrlParse.Host, gitRepoUrlParse.Path), "/", "~")
			cc.WithGit = true
		}

		log.Info("cc", zap.Any("cc", cc))
		return next(cc)
	}
}

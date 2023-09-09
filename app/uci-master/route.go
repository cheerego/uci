package uci_master

import (
	"github.com/cheerego/uci/app/uci-master/internal/web/start"
	"github.com/cheerego/uci/app/uci-master/internal/web/vscode"
	"github.com/labstack/echo/v4"
)

func Routes(engine *echo.Echo) {
	engine.GET("/", func(c echo.Context) error {
		return c.String(200, "uci-master")
	})
	engine.Group("/api/start", start.WithContext, start.EventInit, start.GitCheck, start.EnvInit, start.PickRunner, start.StartVsCode)
	engine.Any("/vscode/*", vscode.VsCode)
}

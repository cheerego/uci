package twilight

import (
	"github.com/cheerego/uci/app/twilight/internal/start"
	"github.com/cheerego/uci/app/twilight/internal/vscode"
	"github.com/labstack/echo/v4"
)

func Routes(engine *echo.Echo) {
	engine.Group("/api/start", start.WithContext, start.EventInit, start.GitCheck, start.StartVsCode)
	engine.Any("/vscode/*", vscode.VsCode)
}

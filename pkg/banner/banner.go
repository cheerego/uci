package banner

import (
	"fmt"
	"github.com/dimiro1/banner"
	"os"
	"runtime"
)

func Render(title, version string, buildTime string) {
	templ := `
{{ .Title "%s" "" 4 }}
Version: %s
BuiltTime: %s
Now: {{ .Now "2006-01-02 15:04:05" }}
NumCPU: %d
`
	banner.InitString(os.Stdout, true, true, fmt.Sprintf(templ, title, version, buildTime, runtime.NumCPU()))
}

package config

import "fmt"

type UciConfigItem string

const (
	UciHomeDir      UciConfigItem = "UCI_HOME_DIR"
	UciDispatchMode UciConfigItem = "UCI_DISPATCH_MODE"
)

func (u UciConfigItem) EnvName() string {
	return fmt.Sprintf("%s_%s", "ENV_", u)
}

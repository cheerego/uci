package config

import "path"

func UciConfigPath() string {
	return path.Join(SystemHomeDir(), "uci.conf")
}

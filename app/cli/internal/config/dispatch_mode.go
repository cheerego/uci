package config

type DispatchMode string

var UciDispatchModeItem *UciConfigItem = NewUciConfigItem("UCI_DISPATCH_MODE", func() string {
	return string(Host)
})

const Host DispatchMode = "host"
const Docker DispatchMode = "docker"
const DockerInDocker DispatchMode = "docker-in-docker"
const RootlessDocker DispatchMode = "rootless-docker"

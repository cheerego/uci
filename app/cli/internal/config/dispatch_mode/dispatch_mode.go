package dispatch_mode

type DispatchMode string

const Host DispatchMode = "host"
const Docker DispatchMode = "docker"
const DockerInDocker DispatchMode = "docker-in-docker"
const RootlessDocker DispatchMode = "rootless-docker"

func Default() DispatchMode {
	return Host
}

package host

import (
	"github.com/docker/docker/client"
	"sync"
)

var dockerClient *client.Client
var mutex sync.Mutex

func Docker() (*client.Client, error) {
	mutex.Lock()
	defer mutex.Unlock()
	if dockerClient != nil {
		return dockerClient, nil
	}
	dockerClient, err := client.NewClientWithOpts(client.FromEnv)
	return dockerClient, err
}

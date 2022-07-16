package moby

import (
	"context"
	"github.com/docker/docker/api/types"
	"github.com/docker/docker/client"
	"io/ioutil"
	"testing"
)

func TestName(t *testing.T) {
	client, err := client.NewClientWithOpts(client.FromEnv)
	if err != nil {
		t.Fatal(err)
	}
	//cheerego-docker.pkg.coding.net/registry/public/php:8-fpm-20220409
	//pull, err := client.ImagePull(context.Background(), "golang:1.18.0-bullseye", types.ImagePullOptions{})
	pull, err := client.ImagePull(context.Background(), "cheerego-docker.pkg.coding.net/registry/public/php:8-fpm-20220409", types.ImagePullOptions{})
	if err != nil {
		t.Fatal(err)
	}

	all, err := ioutil.ReadAll(pull)
	if err != nil {
		t.Fatal(err)
	}

	t.Log(string(all))

}

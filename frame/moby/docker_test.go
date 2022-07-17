package moby

import (
	"context"
	"github.com/cheerego/uci/pkg/ptr"
	"github.com/docker/docker/api/types"
	"github.com/docker/docker/api/types/container"
	"github.com/docker/docker/client"
	"github.com/docker/docker/pkg/stdcopy"
	"os"
	"testing"
	"time"
)

func TestName(t *testing.T) {
	ctx := context.TODO()
	docker, err := client.NewClientWithOpts(client.FromEnv)
	if err != nil {
		t.Fatal(err)
	}
	//cheerego-docker.pkg.coding.net/registry/public/php:8-fpm-20220409
	//pull, err := client.ImagePull(context.Background(), "golang:1.18.0-bullseye", types.ImagePullOptions{})
	image := "cheerego-docker.pkg.coding.net/registry/public/php:8-fpm-20220409"
	pull, err := docker.ImagePull(context.Background(), image, types.ImagePullOptions{})
	if err != nil {
		t.Fatal(err)
	}

	defer pull.Close()

	err = docker.ContainerStop(ctx, "hkn-test", ptr.Ptr(5*time.Second))
	if err != nil {
		t.Fatal(err)
	}
	t.Log("stop container")

	err = docker.ContainerRemove(ctx, "hkn-test", types.ContainerRemoveOptions{})
	if err != nil {
		panic(err)
	}
	t.Log("remove container")

	resp, err := docker.ContainerCreate(ctx, &container.Config{
		Image: image,
	}, nil, nil, nil, "hkn-test")
	if err != nil {
		panic(err)
	}
	t.Log("create container", resp.ID)

	err = docker.ContainerStart(ctx, "hkn-test", types.ContainerStartOptions{})
	if err != nil {
		panic(err)
	}

	t.Log("start container")

	create, err := docker.ContainerExecCreate(ctx, "hkn-test", types.ExecConfig{
		AttachStderr: true,
		AttachStdout: true,
		Cmd: []string{"bash", "-c", `
i=2
sum=0
while [ $i -le 10 ]
do
  let sum=sum+$i
  let i+=2
  echo $sum
  sleep 1
done

echo $sum
`},
	})
	if err != nil {
		panic(err)
	}
	t.Log("exec container ")

	attach, err := docker.ContainerExecAttach(ctx, create.ID, types.ExecStartCheck{})
	if err != nil {
		panic(err)
	}
	t.Log("exec attach container ")
	defer attach.Close()
	stdcopy.StdCopy(os.Stdout, os.Stdout, attach.Reader)

	res, err := docker.ContainerExecInspect(ctx, create.ID)
	if err != nil {
		panic(err)
	}
	t.Log(res.ExitCode)

}

package types

import (
	"fmt"
	"strings"
)

type Env string

const ENV_GIT_REPO_URL = "GIT_REPO_URL"
const ENV_GIT_REPO_USERNAME = "GIT_USERNAME"
const ENV_GIT_REPO_PASSWORD = "GIT_PASSWORD"
const ENV_GIT_REPO_NAME = "GIT_REPO_NAME"
const ENV_TASK_NAME = "TASK_NAME"

type Envs map[Env]string

func (envs Envs) ToDocker() string {

	envArr := make([]string, 0)
	for key, value := range envs {
		envArr = append(envArr, fmt.Sprintf("-e %s=%s", key, value))
	}
	join := strings.Join(envArr, " ")
	return join

}

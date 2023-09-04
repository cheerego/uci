package runner

import (
	"fmt"
	"github.com/cockroachdb/errors"
	"io/ioutil"
	"net/http"
	"strconv"
)

func Exec(taskName string, ip string, port int, shell string, timeoutSecond int) (string, error) {

	client := http.DefaultClient

	req, _ := http.NewRequest("GET", fmt.Sprintf("http://%s:%d/runner/exec", ip, port), nil)

	q := req.URL.Query()
	q.Add("script", shell)
	q.Add("timeout", strconv.Itoa(timeoutSecond))
	req.URL.RawQuery = q.Encode()
	do, err := client.Do(req)
	if err != nil {
		return "", err
	}
	defer do.Body.Close()

	all, err := ioutil.ReadAll(do.Body)
	if err != nil {
		return "", err
	}

	var returnErr error = nil
	if do.StatusCode != 200 {
		returnErr = errors.New("dispatch uci-uci-runner status code != 200")
	}
	return string(all), returnErr
}

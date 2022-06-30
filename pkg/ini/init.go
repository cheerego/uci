package ini

import (
	"fmt"
	"github.com/cockroachdb/errors"
	"io/ioutil"
	"os"
	"path"
	"strings"
	"sync"
)

type Ini struct {
	p     string
	mutex sync.RWMutex
}

func NewIni(p string) (*Ini, error) {
	i := &Ini{p: p}

	f, err := i.openFile()

	if err != nil {
		return nil, err
	}
	defer f.Close()
	return i, nil
}

func (i *Ini) openFile() (*os.File, error) {
	err := os.MkdirAll(path.Dir(i.p), 755)
	if err != nil {
		return nil, err
	}

	file, err := os.OpenFile(i.p, os.O_RDWR|os.O_APPEND|os.O_CREATE, 0644)
	if err != nil {
		return nil, err
	}
	return file, nil
}

func (i *Ini) Write(key string, value string) error {
	file, err := i.openFile()
	if err != nil {
		return err
	}
	defer file.Close()
	_, err = file.WriteString(fmt.Sprintf("%s=%s\n", key, value))
	return err
}

func (i *Ini) ReadAll() (map[string]string, error) {
	file, err := i.openFile()
	if err != nil {
		return nil, err
	}
	defer file.Close()

	contentBytes, err := ioutil.ReadAll(file)
	if err != nil {
		return nil, err
	}
	content := string(contentBytes)
	lines := strings.Split(content, "\n")

	m := make(map[string]string)
	for index, line := range lines {
		if len(line) == 0 {
			continue
		}

		split := strings.SplitN(line, "=", 2)
		if len(split) != 2 {
			return nil, errors.Newf("ini: line %d split by '=' length is not 2, content %s", index+1, line)
		}

		key := split[0]
		value := split[1]
		m[key] = value
	}
	return m, nil
}

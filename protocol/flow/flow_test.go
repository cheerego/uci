package flow

import (
	"fmt"
	"github.com/davecgh/go-spew/spew"
	"gopkg.in/yaml.v2"
	"io/ioutil"
	"os"
	"path"
	"testing"
)

var a = `
t
`

func Test1(t *testing.T) {
	pwd, _ := os.Getwd()
	fileBytes, err := ioutil.ReadFile(path.Join(pwd, "1.yml"))
	if err != nil {
		t.Fatal(err)
	}

	var f FlowYaml
	yaml.Unmarshal(fileBytes, &f)

	fmt.Printf("%+v", f)
	marshal, err := yaml.Marshal(f)
	if err != nil {
		t.Fatal(err)
	}
	t.Log(string(marshal))
}

func Test2(t *testing.T) {
	pwd, _ := os.Getwd()
	fileBytes, err := ioutil.ReadFile(path.Join(pwd, "2.yml"))
	if err != nil {
		t.Fatal(err)
	}

	var f FlowYaml
	yaml.Unmarshal(fileBytes, &f)

	fmt.Printf("%+v", f)
	marshal, err := yaml.Marshal(f)
	if err != nil {
		t.Fatal(err)
	}
	t.Log(string(marshal))
}

func Test3(t *testing.T) {
	pwd, _ := os.Getwd()
	fileBytes, err := ioutil.ReadFile(path.Join(pwd, "3.yml"))
	if err != nil {
		t.Fatal(err)
	}

	var f FlowYaml
	yaml.Unmarshal(fileBytes, &f)

	fmt.Printf("%+v", f)
	marshal, err := yaml.Marshal(f)
	if err != nil {
		t.Fatal(err)
	}
	t.Log(string(marshal))
}

func TestScripts(t *testing.T) {
	pwd, _ := os.Getwd()
	fileBytes, err := ioutil.ReadFile(path.Join(pwd, "1.yml"))
	if err != nil {
		t.Fatal(err)
	}

	var f FlowYaml
	yaml.Unmarshal(fileBytes, &f)

	scripts, err := f.Scripts("123", map[string]string{})
	if err != nil {
		t.Fatal(err)
	}
	spew.Dump(scripts.JobScripts)

}

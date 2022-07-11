package config

import (
	"fmt"
	"github.com/cheerego/uci/pkg/ini"
	"os"
)

type UciConfigItem struct {
	Name    string
	Default func() string
}

var Items = make([]*UciConfigItem, 0)

func NewUciConfigItem(name string, d func() string) *UciConfigItem {
	u := &UciConfigItem{
		Name:    name,
		Default: d,
	}
	Items = append(Items, u)
	return u
}

func (u *UciConfigItem) envName() string {
	return fmt.Sprintf("ENV_%s", u.Name)
}

func (u *UciConfigItem) Value() (string, error) {

	iniParse := ini.NewIni(UciConfigPath())
	m, err := iniParse.ReadAll()
	if err != nil {
		return "", err
	}
	//
	if s, ok := m[u.Name]; ok {
		return s, nil
	} else {
		env, b := os.LookupEnv(u.envName())
		if b {
			return env, nil
		} else {
			return u.Default(), nil
		}
	}
}

func Map() map[string]*UciConfigItem {
	m := make(map[string]*UciConfigItem)
	for _, item := range Items {
		m[item.Name] = item
	}
	return m
}

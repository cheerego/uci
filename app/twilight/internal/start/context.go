package start

import (
	"crypto/rand"
	"fmt"
	"github.com/labstack/echo/v4"
)

type StartContext struct {
	echo.Context
	StartRequest *StartRequest

	TaskName string

	Event EventType

	WithGit     bool
	GitUsername string
	GitPassword string
	GitHttpUrl  string
}

type StartRequest struct {
	GitUsername   string
	GitPassword   string
	GitHttpUrl    string
	GitCiFilePath string
	GitSha        string

	CiFileContent string

	Event EventType
}

func GetRandomString2(n int) string {
	randBytes := make([]byte, n/2)
	rand.Read(randBytes)
	return fmt.Sprintf("%x", randBytes)
}

func WithContext(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {
		taskName := fmt.Sprintf("%s-%s-%s", "uci", GetRandomString2(6), GetRandomString2(6))

		req := &StartRequest{}
		err := c.Bind(req)
		if err != nil {
			return nil
		}

		return next(&StartContext{Context: c,
			TaskName:     taskName,
			StartRequest: req})
	}
}

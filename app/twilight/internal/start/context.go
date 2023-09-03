package start

import (
	"crypto/rand"
	"fmt"
	"github.com/cheerego/uci/app/twilight/internal/types"
	"github.com/labstack/echo/v4"
)

func GetRandomString2(n int) string {
	randBytes := make([]byte, n/2)
	rand.Read(randBytes)
	return fmt.Sprintf("%x", randBytes)
}

func WithContext(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {
		taskName := fmt.Sprintf("%s-%s-%s", "uci", GetRandomString2(6), GetRandomString2(6))

		req := &types.StartRequest{}
		err := c.Bind(req)
		if err != nil {
			return nil
		}

		return next(&types.StartContext{Context: c,
			TaskName:     taskName,
			StartRequest: req})
	}
}

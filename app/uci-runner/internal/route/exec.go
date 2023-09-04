package route

import (
	"bufio"
	"bytes"
	"context"
	"fmt"
	"github.com/cheerego/uci/pkg/log"
	"github.com/cockroachdb/errors"
	"github.com/labstack/echo/v4"
	"io"
	"os/exec"
	"time"
)

type ExecForm struct {
	Script string `json:"script,omitempty" form:"script" query:"script"`
	// 单位秒
	Timeout int64 `json:"timeout,omitempty" form:"timeout" query:"timeout"`
	Watch   bool  `json:"watch,omitempty" form:"watch" query:"watch"`
}

func Exec(ctx echo.Context) error {
	form := &ExecForm{}
	err := ctx.Bind(form)
	if err != nil {
		return errors.WithStack(err)
	}

	timeout, _ := context.WithTimeout(context.Background(), time.Duration(form.Timeout)*time.Second)
	cmd := exec.CommandContext(timeout, "bash", "-c", "-e", form.Script)

	pipe, err := cmd.StdoutPipe()
	cmd.Stderr = cmd.Stdout

	err = cmd.Start()
	if err != nil {
		return err
	}

	reader := bufio.NewReader(pipe)

	if form.Watch {
		ctx.Response().Header().Set("Transfer-Encoding", "chunked")
		for {
			line, err2 := reader.ReadString('\n')
			if err2 != nil || io.EOF == err2 {
				break
			}
			log.Infof(line)
			ctx.Response().Write([]byte(line))
			ctx.Response().Flush()
		}
		err = cmd.Wait()
		if err != nil {
			ctx.Response().WriteHeader(500)
			ctx.Response().Write([]byte(fmt.Sprintf("%s", err.Error())))
			ctx.Response().Flush()
		}
		ctx.Response().WriteHeader(200)
		ctx.Response().Flush()
		return nil
	} else {
		buffer := bytes.NewBuffer(nil)
		for {
			line, err2 := reader.ReadString('\n')
			if err2 != nil || io.EOF == err2 {
				break
			}
			log.Infof(line)
			buffer.Write([]byte(line))
		}
		err = cmd.Wait()
		if err != nil {
			buffer.WriteString(fmt.Sprintf("%s", err.Error()))
			return ctx.Stream(500, echo.MIMETextPlainCharsetUTF8, buffer)
		}
		return ctx.Stream(200, echo.MIMETextPlainCharsetUTF8, buffer)
	}

}

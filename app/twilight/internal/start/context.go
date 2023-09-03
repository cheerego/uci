package start

import "github.com/labstack/echo/v4"

type Event string

const EventPush Event = "push"
const EventMergeRequest Event = "merge_request"
const EventAPI Event = "api"

type Context struct {
	echo.Context
	Event    Event
	WithRepo bool
}

func WithContext(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {
		return next(&Context{Context: c})
	}
}

package start

import (
	"github.com/cheerego/uci/pkg/uerror"
	"github.com/labstack/echo/v4"
	"github.com/samber/lo"
)

type EventType string

const EventPush EventType = "push"
const EventTag EventType = "tag"
const EventMergeRequest EventType = "merge_request"
const EventMergeTargetRequest EventType = "merge_request_target"
const EventAPI EventType = "api"

var ErrInvalidEventType = uerror.NewUError(400, "ErrInvalidEventType", "无效的事件类型")

var EventTypeList = []EventType{EventPush, EventAPI, EventMergeRequest, EventMergeTargetRequest}

func EventInit(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {
		cc := c.(*StartContext)
		event := cc.StartRequest.Event
		if lo.Contains(EventTypeList, event) {
			cc.Event = event
		} else {
			return ErrInvalidEventType.WithMessagef("event type is '%s'", event)
		}
		return next(cc)
	}
}

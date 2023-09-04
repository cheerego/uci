package types

import "github.com/cheerego/uci/pkg/uerror"

type EventType string

const EventPush EventType = "push"
const EventTag EventType = "tag"
const EventMergeRequest EventType = "merge_request"
const EventAPI EventType = "api"

var ErrInvalidEventType = uerror.NewUError(400, "ErrInvalidEventType", "无效的事件类型")

var EventTypeList = []EventType{EventPush, EventTag, EventAPI, EventMergeRequest}

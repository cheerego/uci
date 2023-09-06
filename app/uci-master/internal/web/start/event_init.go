package start

import (
	"github.com/cheerego/uci/app/uci-master/internal/types"
	"github.com/labstack/echo/v4"
	"github.com/samber/lo"
)

func EventInit(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {
		cc := types.StartContextFromContext(c)
		event := cc.StartRequest.Event
		if lo.Contains(types.EventTypeList, event) {
			cc.Event = event
		} else {
			return types.ErrInvalidEventType.WithMessagef("event type is '%s'", event)
		}
		return next(cc)
	}
}

package flow

import "strings"

func CanExec(s string) bool {
	return strings.HasPrefix(s, "${{") && strings.HasSuffix(s, "}}")
}

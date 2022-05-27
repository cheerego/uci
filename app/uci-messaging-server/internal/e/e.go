package e

import "github.com/cheerego/uci/pkg/uerror"

var ErrClientOffline = uerror.NewUError(500, "ErrClientOffline", "节点状态离线")

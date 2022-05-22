package shim

import "context"

type Shimer interface {
	StartListener(ctx context.Context) error
	//WriteToStorage() error
}

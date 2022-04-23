package shim

type BaseShimer struct {
}

func NewBaseShimer(shimer Shimer) *BaseShimer {
	return &BaseShimer{}
}

func (b *BaseShimer) WriteMessageToStorage(payload string) error {
	return nil
}

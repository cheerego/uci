package shim

type Shimer interface {
	StartListener() error
	//WriteToStorage() error
}

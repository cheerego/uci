package daemon

type Daemoner interface {
	StartListener() error
}

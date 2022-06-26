package facade

import "github.com/assembla/cony"

type AmqpFacade struct {
	cony *cony.Client
}

func NewAmqpFacade() *AmqpFacade {
	//cli := cony.NewClient(
	//	cony.URL(*url),
	//	cony.Backoff(cony.DefaultBackoff),
	//)
	//
	//// Declare the exchange we'll be using
	//exc := cony.Exchange{
	//	Name:       "myExc",
	//	Kind:       "fanout",
	//	AutoDelete: true,
	//}
	//cli.Declare([]cony.Declaration{
	//	cony.DeclareExchange(exc),
	//})
	//
	return &AmqpFacade{}

}

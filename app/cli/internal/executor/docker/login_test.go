package docker

import (
	"github.com/docker/distribution/reference"
	"net/url"
	"testing"
)

func TestLogin(t *testing.T) {

	parse, err := url.Parse("nginx:latest")
	t.Log(
		parse.Path,
		err,
	)

	parse4, err := url.Parse("nginx")
	t.Log(
		parse4.Path,
		err)

	parse1, err := url.Parse("asdf/nginx:latest")
	t.Log(
		parse1.Path,
		err,
	)

	parse2, err := url.Parse("cheerego-docker.pkg.coding.net/nginx:latest")
	t.Log(
		parse2.Path,
		err,
	)
	ref, err := reference.ParseNormalizedNamed("nginx:latest")

	t.Log(ref.Name(), reference.Domain(ref), ref, err)
	name := reference.FamiliarName(ref)
	t.Log(name)

	anyReference, err := reference.ParseAnyReference("nginx")
	anyReference.String()
	t.Log(anyReference.String(), err)

}

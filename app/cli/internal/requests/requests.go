package requests

import (
	"github.com/cheerego/uci/app/cli/internal/uerror"
	"github.com/cockroachdb/errors"
	"github.com/go-resty/resty/v2"
)

func doPost(request *resty.Request, url string) error {
	var result = make(map[string]interface{})
	resp, err := request.
		SetResult(result).
		Post(url)
	if err != nil {
		return errors.Wrapf(err, "url: %s, body: %v, queryParam: %v, result: %v", resp.Request.URL, resp.Request.Body, resp.Request.QueryParam, result)
	}
	if resp.StatusCode() != 200 {
		return errors.Wrapf(uerror.ErrHttpResponseCodeNot200, "url: %s, body: %v, queryParam: %v, statusCode: %v result: %v", resp.Request.URL, resp.Request.Body, resp.Request.QueryParam, resp.StatusCode(), result)
	}
	return nil
}

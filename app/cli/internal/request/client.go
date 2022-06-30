package request

import (
	"crypto/tls"
	"github.com/go-resty/resty/v2"
	"net/http"
	"time"
)

var client = resty.
	NewWithClient(&http.Client{
		Transport: http.DefaultTransport,
	}).
	SetTLSClientConfig(&tls.Config{
		InsecureSkipVerify: true,
	}).
	SetRetryCount(3).
	SetRetryWaitTime(2*time.Second).
	SetHeader("Content-Type", "application/json")

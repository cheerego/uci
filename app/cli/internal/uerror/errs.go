package uerror

var ErrContextCanceledOrTimeout = NewUError("ErrContextCanceledOrTimeout", "命令行 Context 被取消或超时")

var ErrHttpResponseCodeNot200 = NewUError("ErrHttpResponseCodeNot200", "http 请求返回状态码不为 200")

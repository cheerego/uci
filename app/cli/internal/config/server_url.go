package config

var UciServerUrl = NewUciConfigItem("UCI_SERVER_URL", func() string {
	return "http://messaging.uci.127.0.0.1.nip.io"
})

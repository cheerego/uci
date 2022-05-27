<?php


return [
    "uci_dispatch_server_http" => env("UCI_DISPATCH_SERVER_HTTP_ENTRYPOINT", "uci-dispatch-server:8080"),
    "uci_messaging_server_http" => env("UCI_MESSAGING_SERVER_HTTP_ENTRYPOINT", "uci-messaging-server:8080")
];

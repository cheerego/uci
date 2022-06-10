<?php

namespace App\Rpcs;


use GuzzleHttp\Client;

class UciMessaingRpcClient
{

    private $addr;
    private $client;

    public function __construct()
    {
        $this->addr = config("rpc.uci_messaging_server_http");
        $this->client = new Client([
            'base_uri' => $this->addr,
            'timeout' => 0,
        ]);
    }


    /**
     * @throws \GuzzleHttp\Exception\GuzzleException
     */
    public function request(string $method, $uri = '', array $options = []): \Psr\Http\Message\ResponseInterface
    {
        return $this->client->request($method, $uri, $options);
    }
}


<?php

namespace App\Rpcs;


use GuzzleHttp\Client;

class UciMessaingRpcClient
{

    private $addr;
    private $client;

    public function __construct($addr)
    {
        $this->addr = $addr;
        $this->client = new Client([
            'base_uri' => $addr,
            'timeout' => 0,
        ]);
    }


    public function request(string $method, $uri = '', array $options = []): \Psr\Http\Message\ResponseInterface
    {
        return $this->client->request($method, $uri, $options);
    }
}


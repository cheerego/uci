<?php

namespace App\Services;


use GuzzleHttp\Client;

class PipelineService
{
    public function __construct()
    {
    }

    public function triggerBuild($pipelineId): string
    {
        app(Client::class)->request("GET", "http://uci-messaging-server:8080");
    }
}


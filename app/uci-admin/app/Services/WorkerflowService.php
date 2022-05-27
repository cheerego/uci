<?php

namespace App\Services;


use App\Rpcs\UciMessaingRpcClient;

class WorkerflowService
{
    /**
     * @var UciMessaingRpcClient
     */
    private $uciMessagingClient;

    public function __construct(UciMessaingRpcClient $uciMessagingClient)
    {
        $this->uciMessagingClient = $uciMessagingClient;
    }

    public function triggerBuild($pipelineId): string
    {
        app(UciMessaingRpcClient::class)->request("POST", "/api/vi/inner/workerflow/trigger");
    }
}


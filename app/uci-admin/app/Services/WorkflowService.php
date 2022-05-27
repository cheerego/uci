<?php

namespace App\Services;


use App\Rpcs\UciMessaingRpcClient;

class WorkflowService
{
    /**
     * @var UciMessaingRpcClient
     */
    private $uciMessagingClient;

    public function __construct(UciMessaingRpcClient $uciMessagingClient)
    {
        $this->uciMessagingClient = $uciMessagingClient;
    }

    public function triggerBuild($workflowId): \Psr\Http\Message\ResponseInterface
    {
        return app(UciMessaingRpcClient::class)->request("POST", "/api/v1/inner/workflow/" . $workflowId . "/trigger");
    }
}


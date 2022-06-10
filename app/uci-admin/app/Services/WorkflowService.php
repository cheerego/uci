<?php

namespace App\Services;


use App\Rpcs\UciMessaingRpcClient;

class WorkflowService
{
    /**
     * @var UciMessaingRpcClient
     */
    private $uciMessagingClient;

    public function __construct()
    {

        $this->uciMessagingClient = app(UciMessaingRpcClient::class);
    }

    public function triggerBuild($workflowId, $params): \Psr\Http\Message\ResponseInterface
    {
        return app(UciMessaingRpcClient::class)->request("POST", "/api/v1/inner/workflow/" . $workflowId . "/trigger", [
            "json" => $params,
        ]);
    }
}


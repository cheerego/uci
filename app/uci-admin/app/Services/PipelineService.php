<?php

namespace App\Services;


class PipelineService
{
    private $pipelineTaskService;
    public function __construct()
    {
        $this->pipelineTaskService = app(PipelineTaskService::class);
    }

    public function echo(): string
    {
        return $this->pipelineTaskService->echo();
    }
}


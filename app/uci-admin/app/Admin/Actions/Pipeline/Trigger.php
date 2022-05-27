<?php

namespace App\Admin\Actions\Pipeline;

use App\Models\Workflow;
use App\Services\WorkflowService;
use Encore\Admin\Actions\RowAction;

class Trigger extends RowAction
{
    public $name = '触发构建';

    public function handle(Workflow $model)
    {
        $workflowService = app(WorkflowService::class);
        $resp = $workflowService->triggerBuild($model->id);
        if ($resp->getStatusCode() != 200) {
            return $this->response->error("触发构建失败" . $resp->getBody())->refresh();
        }
        return $this->response()->success('触发构建成功')->refresh();
    }

}

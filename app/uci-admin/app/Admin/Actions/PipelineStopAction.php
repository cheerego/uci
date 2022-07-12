<?php

namespace App\Admin\Actions;

use App\Services\WorkflowService;
use Encore\Admin\Actions\RowAction;
use Illuminate\Database\Eloquent\Model;

class PipelineStopAction extends RowAction
{
    public $name = '终止';

    public function handle(Model $model)
    {
        $workflowService = app(WorkflowService::class);
        $resp = $workflowService->stop($model->id);
        if ($resp->getStatusCode() != 200) {
            return $this->response()->error("终止失败" . $resp->getBody())->refresh();
        }
        return $this->response()->success("终止成功")->refresh();
    }

}

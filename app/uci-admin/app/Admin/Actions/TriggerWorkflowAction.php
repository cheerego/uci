<?php

namespace App\Admin\Actions;

use App\Models\Workflow;
use App\Services\WorkflowService;
use Encore\Admin\Actions\RowAction;

class TriggerWorkflowAction extends RowAction
{
    public $name = '触发构建';

    public function handle(Workflow $model)
    {
        $workflowService = app(WorkflowService::class);

        $revision = request()->input("revision");
        $param_envs_str = request()->input("envs", "[]");
        $param_envs = json_decode($param_envs_str);
        $envs = [];
        foreach ($param_envs as $key => $value) {
            $envs[] = ["key" => $key, "value" => $value];
        }
        $params = [
            "revision" => $revision,
            "envs" => $envs
        ];
        $resp = $workflowService->trigger($model->id, $params);
        if ($resp->getStatusCode() != 200) {
            return $this->response()->error("触发构建失败" . $resp->getBody())->refresh();
        }
        return $this->response()->success("触发构建成功")->refresh();
    }

    public function form()
    {
        $this->text("revision", __("Revision"));
        $this->text("param_envs", __("Param Envs"))->default(json_encode($this->row->envs));
    }

}

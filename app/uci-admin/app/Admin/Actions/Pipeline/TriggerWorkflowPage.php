<?php

namespace App\Admin\Actions\Pipeline;

use App\Models\Workflow;
use App\Services\WorkflowService;
use Encore\Admin\Actions\RowAction;

class TriggerWorkflowPage extends RowAction
{
    public $name = '触发构建1';

    public function handle(Workflow $model)
    {
        $workflowService = app(WorkflowService::class);

        $revision = request()->input("revision");
//        $param_envs = $request->input("envs", []);
//        $needle_param_envs = [];
//        foreach ($param_envs as $key => $value) {
//            $needle_param_envs[] = $value;
//        }
        $params = [
            "revision" => $revision,
//            "envs" => $needle_param_envs
        ];
        $resp = $workflowService->triggerBuild($model->id, $params);
        if ($resp->getStatusCode() != 200) {
            return $this->response()->error("触发构建失败" . $resp->getBody())->refresh();
        }
        return $this->response()->success("触发构建成功")->refresh();
    }

    public function form()
    {
        $this->text("revision", __("Revision"));
//        $this->text("envs",)
//        $this->table('envs', __('Param envs'), function ($table) {
//            $table->text('key');
//            $table->text('value');
//        });
    }

}

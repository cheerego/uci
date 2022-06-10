<?php

namespace App\Admin\Actions\Pipeline;

use App\Models\Workflow;
use Encore\Admin\Actions\RowAction;

class TriggerWorkflowPage extends RowAction
{
    public $name = '触发构建1';

    public function handle(Workflow $model)
    {
        return $this->response()->redirect(route(admin_get_route("workflows.trigger.page"),[$model->id]));
    }

}

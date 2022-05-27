<?php

namespace App\Admin\Actions\Pipeline;

use App\Models\Pipeline;
use App\Rpcs\UciMessaingRpcClient;
use Encore\Admin\Actions\RowAction;

class Trigger extends RowAction
{
    public $name = '触发构建';

    public function handle(Pipeline $model)
    {


        $triggerBuild = app(UciMessaingRpcClient::class)->t($model->id);
        return $this->response()->success('Success message.')->refresh();
    }

}

<?php

namespace App\Admin\Actions\Pipeline;

use App\Models\Pipeline;
use Encore\Admin\Actions\RowAction;

class Trigger extends RowAction
{
    public $name = '触发构建';

    public function handle(Pipeline $model)
    {
        // $model ...
        var_dump($model);

        return $this->response()->success('Success message.')->refresh();
    }

}

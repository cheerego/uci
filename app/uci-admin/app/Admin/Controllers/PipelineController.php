<?php

namespace App\Admin\Controllers;

use App\Admin\Actions\Pipeline\Trigger;
use App\Models\Pipeline;
use App\Services\UciMessaingRpcClient;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class PipelineController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Pipeline';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new Pipeline());


        $grid->actions(function (Grid\Displayers\Actions $actions) {
            $actions->add(new Trigger());
        });


        $grid->column("id", "Id");
        $grid->column("yaml", "Yaml");
        $grid->column("created_at", __("admin.created_at"));
        $grid->column("updated_at", __("admin.updated_at"));

        $grid->column("adf")->display(function () {
            return app(UciMessaingRpcClient::class)->echo();
        });


        return $grid;
    }

    /**
     * Make a show builder.
     *
     * @param mixed $id
     * @return Show
     */
    protected function detail($id)
    {
        $show = new Show(Pipeline::query()->findOrFail($id));
        $show->field('id', 'ID');
        $show->field('name', '名称');
        $show->field("content", "编排内容");


        return $show;
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        $form = new Form(new Pipeline());
        $form->display('id', 'ID');
        $form->text('name', '名称');
        $form->textarea("content", "编排内容");
        return $form;
    }
}

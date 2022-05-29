<?php

namespace App\Admin\Controllers;

use App\Admin\Actions\Pipeline\Trigger;
use App\Models\Workflow;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Facades\Admin;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;
use Encore\Admin\Widgets\Table;

class WorkflowController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Workflow';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new Workflow());

        $grid->column('id', __('Id'));
        $grid->column('name', __('Name'));
        $grid->column('yaml', __('Yaml'));
        $grid->column('creator_id', __('Creator id'));
//        $grid->column('param_envs', __('Param envs'))

        $grid->column('envs', __('Param envs'))->expand(function ($model) {
            return new Table(['Key', 'Value',], collect($model->param_envs)->toArray());
        });

        $grid->column("pipelines", __("Pipelines"))->display(function () {
            $route = route("admin.pipelines.index", ["workflow_id" => $this->id]);
            return "<a class='label label-default' href='{$route}'>Pipelines</a>";
        });

        $grid->column('created_at', __('Created at'));
        $grid->column('updated_at', __('Updated at'));
        $grid->column('deleted_at', __('Deleted at'));
        $grid->actions(function (Grid\Displayers\Actions $actions) {
            $actions->add(new Trigger());
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
        $show = new Show(Workflow::query()->findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('name', __('Name'));
        $show->field('yaml', __('Yaml'));
        $show->field('creator_id', __('Creator id'));
//        $show->field('param_envs', __('Param envs'));
        $show->field('created_at', __('Created at'));
        $show->field('updated_at', __('Updated at'));
        $show->field('deleted_at', __('Deleted at'));

        return $show;
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        $form = new Form(new Workflow());

        $form->text('name', __('Name'));
        $form->textarea('yaml', __('Yaml'));
        $form->hidden('creator_id', __('Creator id'));
        $form->table('param_envs', __('Param envs'), function ($table) {
            $table->text('key');
            $table->text('value');
        });


        $form->saving(function (Form $form) {
            if ($form->isCreating()) {
                $form->creator_id = Admin::user()->id;
            }
        });
        return $form;
    }
}

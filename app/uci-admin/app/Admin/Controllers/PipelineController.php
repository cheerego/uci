<?php

namespace App\Admin\Controllers;

use App\Models\Pipeline;
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
        $grid->model()->orderByDesc("id");

        $grid->column('id', __('Id'));
        $grid->column('workflow_id', __('Workflow id'));
        $grid->column('yaml', __('Yaml'));
        $grid->column('salt', __('Salt'));
        $grid->column('last_dispatch_at', __('Last dispatch time'));
        $grid->column('dispatch_times', __('Dispatch times'));
        $grid->column('status', __('Status'));
        $grid->column('status_message', __('Status message'));
        $grid->column('uuid', __('Uuid'));
        $grid->column('raw_log', __('Raw log'));
        $grid->column('created_at', __('Created at'));
        $grid->column('updated_at', __('Updated at'));
        $grid->column('deleted_at', __('Deleted at'));



        $grid->filter(function (Grid\Filter $filter){
            $filter->equal('workflow_id', 'workflow_id');
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
        $show = new Show(Pipeline::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('workflow_id', __('Workflow id'));
        $show->field('yaml', __('Yaml'));
        $show->field('salt', __('Salt'));
        $show->field('last_dispatch_time', __('Last dispatch time'));
        $show->field('dispatch_times', __('Dispatch times'));
        $show->field('status', __('Status'));
        $show->field('status_message', __('Status message'));
        $show->field('uuid', __('Uuid'));
        $show->field('raw_log', __('Raw log'));
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
        $form = new Form(new Pipeline());

        $form->number('workflow_id', __('Workflow id'));
        $form->textarea('yaml', __('Yaml'));
        $form->text('salt', __('Salt'));
        $form->datetime('last_dispatch_time', __('Last dispatch time'))->default(date('Y-m-d H:i:s'));
        $form->number('dispatch_times', __('Dispatch times'));
        $form->text('status', __('Status'))->default('Queuing');
        $form->text('status_message', __('Status message'));
        $form->text('uuid', __('Uuid'));
        $form->textarea('raw_log', __('Raw log'));

        return $form;
    }
}

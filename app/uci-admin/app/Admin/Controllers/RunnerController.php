<?php

namespace App\Admin\Controllers;

use App\Models\Runner;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class RunnerController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Runner';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new Runner());

        $grid->column('id', __('Id'));
        $grid->column('code', __('Code'));
        $grid->column('salt', __('Salt'));
        $grid->column('status', __('Status'));
        $grid->column('last_status_changed_at', __('Last status changed at'));
        $grid->column('last_dispatched_at', __('Last dispatched at'));
        $grid->column('created_at', __('Created at'));
        $grid->column('updated_at', __('Updated at'));
        $grid->column('deleted_at', __('Deleted at'));

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
        $show = new Show(Runner::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('code', __('Code'));
        $show->field('salt', __('Salt'));
        $show->field('status', __('Status'));
        $show->field('last_status_changed_at', __('Last status changed at'));
        $show->field('last_dispatched_at', __('Last dispatched at'));
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
        $form = new Form(new Runner());

        $form->text('code', __('Code'));
        $form->text('salt', __('Salt'));
        $form->text('status', __('Status'))->default('1');
        $form->datetime('last_status_changed_at', __('Last status changed at'))->default(date('Y-m-d H:i:s'));
        $form->datetime('last_dispatched_at', __('Last dispatched at'))->default(date('Y-m-d H:i:s'));

        return $form;
    }
}

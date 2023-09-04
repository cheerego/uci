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

        $grid->column('id', __('Id'))->sortable();
        $grid->column('host', __('Host'));
        $grid->column('port', __('Port'));
        $grid->column('enable', __('Enable'))->switch();
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
        $show->field('host', __('Host'));
        $show->field('port', __('Port'));
        $show->field('enable', __('Enable'));
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

        $form->text('host', __('Host'));
        $form->number('port', __('Port'))->default(8080);
        $form->switch('enable', __('Enable'));

        return $form;
    }
}

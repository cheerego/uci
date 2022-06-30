<?php

namespace App\Admin\Controllers;

use App\Admin\Actions\TriggerWorkflowAction;
use App\Models\Workflow;
use App\Services\WorkflowService;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Facades\Admin;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Layout\Content;
use Encore\Admin\Show;
use Encore\Admin\Widgets\Box;
use Encore\Admin\Widgets\Table;
use Illuminate\Http\Request;

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
//        $grid->column('envs', __('Envs'));

        $grid->column('Envs', __('Envs'))->expand(function ($model) {
            return new Table(['Key', 'Value',], collect($model->envs)->toArray());
        });

        $grid->column("pipelines", __("Pipelines"))->display(function () {
            $route = route("admin.pipelines.index", ["workflow_id" => $this->id]);
            return "<a class='label label-default' href='{$route}'>Pipelines</a>";
        });

        $grid->column('created_at', __('Created at'));
        $grid->column('updated_at', __('Updated at'));
        $grid->column('deleted_at', __('Deleted at'));
        $grid->actions(function (Grid\Displayers\Actions $actions) {
            $actions->add(new TriggerWorkflowAction());
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
//        $show->field("envs", __("Envs"));
        $show->field("envs", __("Envs"))->json();
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
        $form->table('envs', __('Envs'), function ($table) {
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


    public function triggerPage(Request $request, Content $content, $workflow_id)
    {
        $workflow = Workflow::query()->find($workflow_id);
        $content->title('Workflow');

        $form = new \Encore\Admin\Widgets\Form($workflow);

        $form->method('post');
        $form->action(route(admin_get_route("workflows.trigger.action"), [$workflow->id]));

        $form->id("id", "Id");
        $form->textarea("yaml", __("Yaml"))->disable();
        $form->table('envs', __('Param envs'), function ($table) {
            $table->text('key');
            $table->text('value');
        });
        $content->body(new Box('触发构建', $form));
        return $content;
    }


    public function triggerAction(Request $request, WorkflowService $workflowService, $workflow_id)
    {
        admin_toastr('Message...', 'error');


        $revision = $request->input("revision");
        $param_envs = $request->input("envs", []);
        $needle_param_envs = [];
        foreach ($param_envs as $key => $value) {
            $needle_param_envs[] = $value;
        }
        $params = [
            "revision" => $revision,
            "envs" => $needle_param_envs
        ];
        $resp = $workflowService->triggerBuild($workflow_id, $params);
        if ($resp->getStatusCode() != 200) {
            admin_toastr("触发构建失败" . $resp->getBody(), "error");
        }
        admin_toastr("触发构建成功");
    }

}

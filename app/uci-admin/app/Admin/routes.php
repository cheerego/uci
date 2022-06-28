<?php

use Illuminate\Routing\Router;

Admin::routes();

Route::group([
    'prefix' => config('admin.route.prefix'),
    'namespace' => config('admin.route.namespace'),
    'middleware' => config('admin.route.middleware'),
    'as' => config('admin.route.prefix') . '.',
], function (Router $router) {

    $router->get('/', 'HomeController@index')->name('home');


    $router->get("workflows/{workflow_id}/trigger", "WorkflowController@triggerPage")->name("workflows.trigger.page");
    $router->post("workflows/{workflow_id}/trigger", "WorkflowController@triggerAction")->name("workflows.trigger.action");
    $router->resource("workflows", WorkflowController::class);
    $router->resource('pipelines', PipelineController::class);
    $router->resource('runners', RunnerController::class);

});

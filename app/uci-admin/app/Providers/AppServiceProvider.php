<?php

namespace App\Providers;

use App\Services\PipelineService;
use App\Services\PipelineTaskService;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
        $this->app->singleton(PipelineService::class,function ($app){
            return new PipelineService();
        });


        $this->app->singleton(PipelineTaskService::class,function ($app){
            return new PipelineTaskService();
        });
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }
}

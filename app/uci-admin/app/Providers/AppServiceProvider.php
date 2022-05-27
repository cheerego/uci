<?php

namespace App\Providers;

use App\Services\PipelineService;
use App\Rpcs\UciMessaingRpcClient;
use GuzzleHttp\Client;
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
        $this->app->singleton(PipelineService::class, function ($app) {
            return new PipelineService();
        });
        $this->app->singleton(UciMessaingRpcClient::class, function ($app) {
            config("")
            return new UciMessaingRpcClient()
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

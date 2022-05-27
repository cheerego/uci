<?php

namespace App\Providers;

use App\Services\WorkflowService;
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
        $this->app->singleton(UciMessaingRpcClient::class, function ($app) {
            return new UciMessaingRpcClient(config("rpc.uci_messaging_server_http"));
        });
        //

    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        $this->app->singleton(WorkflowService::class, function (\Illuminate\Contracts\Foundation\Application $app) {
            return new WorkflowService($app[UciMessaingRpcClient::class]);
        });

    }
}

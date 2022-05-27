<?php

namespace App\Providers;

use App\Services\WorkerflowService;
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
        $this->app->singleton(WorkerflowService::class, function ($app) {
            return new WorkerflowService();
        });
        $this->app->singleton(UciMessaingRpcClient::class, function ($app) {
            return new UciMessaingRpcClient(config("rpc.uci_messaging_server_http"));
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

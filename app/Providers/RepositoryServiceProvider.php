<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use App\Repositories\BaseRepositoryInterface;
use App\Repositories\BaseEloquentAPIRepository;
use App\Repositories\Eloquent\StationRepository;
use App\Repositories\Eloquent\BusRepository;
use App\Repositories\Eloquent\BusRouteRepository;
use App\Repositories\Eloquent\BusRouteStationRepository;
use App\Repositories\Eloquent\RouteRepository;
use App\Repositories\Eloquent\UserRepository;
use App\Repositories\Interfaces\StationRepositoryInterface;
use App\Repositories\Interfaces\BusRepositoryInterface;
use App\Repositories\Interfaces\BusRouteRepositoryInterface;
Use App\Repositories\Interfaces\BusRouteStationRepositoryInterface;
use App\Repositories\Interfaces\RouteRepositoryInterface;
use App\Repositories\Interfaces\UserRepositoryInterface;

class RepositoryServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     *
     * @return void
     */
    public function register()
    {
        $this->app->bind(BaseRepositoryInterface::class, BaseEloquentAPIRepository::class);
        $this->app->bind(StationRepositoryInterface::class, StationRepository::class);
        $this->app->bind(BusRepositoryInterface::class, BusRepository::class);
        $this->app->bind(BusRouteRepositoryInterface::class, BusRouteRepository::class);
        $this->app->bind(BusRouteStationRepositoryInterface::class, BusRouteStationRepository::class);
        $this->app->bind(RouteRepositoryInterface::class, RouteRepository::class);
        $this->app->bind(UserRepositoryInterface::class, UserRepository::class);
    }

    /**
     * Bootstrap services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }
}

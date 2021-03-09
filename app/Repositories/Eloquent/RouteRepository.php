<?php

namespace App\Repositories\Eloquent;


use App\Repositories\BaseEloquentAPIRepository;
use App\Repositories\Interfaces\RouteRepositoryInterface;
use App\Models\Route;

class RouteRepository extends BaseEloquentAPIRepository implements RouteRepositoryInterface
{
    protected $searchable = [
        'query' => [
            'name',
        ],
    ];
    /**
    * BusRouteStationRepository constructor.
    *
    * @param Route $model
    */
   public function __construct(Route $model)
   {
       parent::__construct($model);
   }
}
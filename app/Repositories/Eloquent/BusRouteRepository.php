<?php

namespace App\Repositories\Eloquent;


use App\Repositories\BaseEloquentAPIRepository;
use App\Repositories\Interfaces\BusRouteRepositoryInterface;
use App\Models\BusRoute;

class BusRouteRepository extends BaseEloquentAPIRepository implements BusRouteRepositoryInterface
{
    /**
    * BusRouteRepository constructor.
    *
    * @param BusRoute $model
    */
   public function __construct(BusRoute $model)
   {
       parent::__construct($model);
   }
}
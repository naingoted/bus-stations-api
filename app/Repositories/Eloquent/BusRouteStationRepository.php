<?php

namespace App\Repositories\Eloquent;


use App\Repositories\BaseEloquentAPIRepository;
use App\Repositories\Interfaces\BusRouteStationRepositoryInterface;
use App\Models\BusRouteStation;

class BusRouteStationRepository extends BaseEloquentAPIRepository implements BusRouteStationRepositoryInterface
{
    /**
    * BusRouteStationRepository constructor.
    *
    * @param BusRouteStation $model
    */
   public function __construct(BusRouteStation $model)
   {
       parent::__construct($model);
   }
}
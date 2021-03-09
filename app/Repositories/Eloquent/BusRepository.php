<?php

namespace App\Repositories\Eloquent;


use App\Repositories\BaseEloquentAPIRepository;
use App\Repositories\Interfaces\BusRepositoryInterface;
use App\Models\Bus;
use Illuminate\Support\Facades\DB;

class BusRepository extends BaseEloquentAPIRepository implements BusRepositoryInterface
{
    /**
    * BusRepository constructor.
    *
    * @param Bus $model
    */
   public function __construct(Bus $model)
   {
       parent::__construct($model);
   }

   public function findBusesByStationId($stationId){
        try {
            $buses = DB::table('buses')
                ->select(DB::raw("buses.id, buses.busCode"))
                ->leftJoin('bus_routes', 'buses.id', '=', 'bus_routes.busId')
                ->leftJoin('bus_route_stations', 'bus_routes.id', "=", 'bus_route_stations.busRouteId')
                ->where('bus_route_stations.stationId', "=", $stationId)
                ->where('buses.status', "=", 1)->distinct()
                ->paginate();
            return $this->success("Retrieved successfully", $buses);
        } catch(\Exception $e) {
            return $this->error($e->getMessage(), $e->getCode());
        }
    }

    public function createBusWithRouteAndStation(array $data){
        DB::beginTransaction();
        try {
            $bus = $this->model->create(["busCode" => $data["busCode"], "status" => $data["status"]]);
            if($bus){
                $busRoute = $bus->busRoute()->create(["routeId" => $data["routeId"], "busId" => $bus->id]);
                if($busRoute){
                    $busRouteStation = $busRoute->busRouteStation()->create(["stationId" => $data["stationId"], "busRouteId" => $busRoute->id]);
                    if($busRouteStation){
                        DB::commit();
                        return $this->success("Added successfully", [
                            'bus'=>$bus,
                            'busRoute'=>$busRoute,
                            'busRouteStation'=>$busRouteStation
                        ], 201);
                    }
                }
            }
            DB::rollBack();
            return $this->error("Update failed. Try again.", 404);
        } catch(\Exception $e) {
            DB::rollBack();
            return $this->error($e->getMessage(), $e->getCode());
        }
    }
}
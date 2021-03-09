<?php

namespace App\Repositories\Eloquent;


use App\Repositories\BaseEloquentAPIRepository;
use App\Repositories\Interfaces\StationRepositoryInterface;
use App\Models\Station;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

class StationRepository extends BaseEloquentAPIRepository implements StationRepositoryInterface
{
    protected $searchable = [
        'query' => [
            'name',
        ],
    ];
    /**
    * StationRepository constructor.
    *
    * @param Station $model
    */
   public function __construct(Station $model)
   {
       parent::__construct($model);
   }

   public function findNearByStation(Request $request){
        try {
            $lat = $request['lat'];
            $lon = $request['lon'];
            $nearbyStations = DB::table("stations")
                                ->select(DB::raw("
                                        id,name,stationCode, ( 6371 * acos( cos( radians(" . $lat . ") ) 
                                        * cos( radians( lat ) ) * cos( radians( lon ) - radians(" . $lon . ") ) + sin( radians(" . $lat . ") ) 
                                        * sin( radians( lat ) ) ) ) AS distance"))->havingRaw('distance < 50')->orderBy('distance')
                                ->paginate(5);
            return $this->success("Retrieved successfully", $nearbyStations);
        } catch(\Exception $e) {
            return $this->error($e->getMessage(), $e->getCode());
        }
   }
}
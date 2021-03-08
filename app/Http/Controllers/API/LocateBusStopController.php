<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;

class LocateBusStopController extends Controller
{
    /**
     * @param lat, lon
     * lat=1.314&lon=103.6839
     * @todo dynamic pagination
     * SELECT id, ( 6371 * acos( cos( radians(1.4228059) ) * cos( radians( lat ) ) * cos( radians( lon ) - radians(103.8366647) ) 
     * + sin( radians(1.4228059) ) * sin( radians( lat ) ) ) ) 
     * AS distance FROM stations HAVING distance < 50 ORDER BY distance ;
     */
    public function getBusStopNearBy(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'lat' => 'required|numeric',
            'lon' => 'required|numeric',
        ]);
        if ($validator->fails()) {
            return response(['errors' => $validator->errors()->all()], 422);
        }
        $lat = $request['lat'];
        $lon = $request['lon'];
        // $lat = 1.4228059;
        // $lon = 103.8366647;
        $busStops = DB::table("stations")->select(DB::raw("
                    id,name,stationCode, ( 6371 * acos( cos( radians(" . $lat . ") ) 
                    * cos( radians( lat ) ) * cos( radians( lon ) - radians(" . $lon . ") ) + sin( radians(" . $lat . ") ) 
                    * sin( radians( lat ) ) ) ) AS distance"))->havingRaw('distance < 50')->orderBy('distance')
            ->paginate(5);
        return response($busStops, 200);
    }
    /**
     * @param stationId
     * 16, 9 , 19 nearest stations
     * @todo join with bus_run_timing to get eta and etd
     * @todo dynamic pagination
     */
    public function getBusListByBusStop(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'stationId' => 'required|numeric',
        ]);
        $stationId = $request['stationId'];
        if ($validator->fails()) {
            return response(['errors' => $validator->errors()->all()], 422);
        }

        $buses = DB::table('buses')
            ->select(DB::raw("buses.id, buses.busCode"))
            ->leftJoin('bus_routes', 'buses.id', '=', 'bus_routes.busId')
            ->leftJoin('bus_route_stations', 'bus_routes.id', "=", 'bus_route_stations.busRouteId')
            ->where('bus_route_stations.stationId', "=", $stationId)
            ->where('buses.status', "=", 1)->distinct()
            ->paginate();
        return response($buses, 200);
    }
}

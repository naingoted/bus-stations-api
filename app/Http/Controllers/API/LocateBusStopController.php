<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Repositories\Interfaces\StationRepositoryInterface;
use App\Repositories\Interfaces\BusRepositoryInterface;

class LocateBusStopController extends Controller
{
    private $stationRepository;

    public function __construct(StationRepositoryInterface $stationRepository, BusRepositoryInterface $busRepository)
    {
        $this->stationRepository = $stationRepository;
        $this->busRepository = $busRepository;
    }

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

        return $this->stationRepository->findNearByStation($request);
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
        return $this->busRepository->findBusesByStationId($stationId);
    }
}

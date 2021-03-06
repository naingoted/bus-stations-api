<?php

namespace App\Http\Controllers\API;

use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use App\Models\Bus;
use App\Models\BusRoute;
use App\Models\BusRouteStation;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Http\Resources\BusResource;
use App\Http\Resources\BusRouteResource;
use App\Http\Resources\BusRouteStationResource;

class BusController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $response = Bus::all();
        return response(['buses' => BusResource::collection($response), 'message' => 'Retrieved successfully'], 200);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $data = $request->all();

        $validator = Validator::make($data, [
            'busCode' => 'required|max:255|unique:buses',
            'status' => 'numeric|required',
            'routeId' => 'numeric|required',
            'stationId' => 'numeric|required',
        ]);

        if ($validator->fails()) {
            return response(['error' => $validator->errors(), 'Validation Error']);
        }

        // DB::transaction(function ($data) {
        // $bus = Bus::create(["busCode" => $data["busCode"], "status" => $data["status"]]);
        // // create bus_route by busId and routeId
        // $busRoute = BusRoute::create(["routeId" => $data["routeId"], "busId" => $bus->id]);
        // // create bus_route_statino by busRouteId and stationId
        // $busRouteStation = BusRouteStation::create(["stationId" => $data["stationId"], "busRouteId" => $busRoute->id]);
        // return response(['buses' => new BusResource($bus), 'message' => 'Created successfully'], 201);
        // });
        $bus = Bus::create(["busCode" => $data["busCode"], "status" => $data["status"]]);
        // create bus_route by busId and routeId
        $busRoute = BusRoute::create(["routeId" => $data["routeId"], "busId" => $bus->id]);
        // create bus_route_statino by busRouteId and stationId
        $busRouteStation = BusRouteStation::create(["stationId" => $data["stationId"], "busRouteId" => $busRoute->id]);

        return response([
            'buses' => new BusResource($bus),
            'busRoute' => new BusRouteResource($busRoute),
            'busRouteStation' => new BusRouteStationResource($busRouteStation),
            'message' => 'Created successfully'
        ], 201);
    }
}

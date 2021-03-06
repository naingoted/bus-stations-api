<?php

namespace App\Http\Controllers\API;

use App\Models\BusRouteStation;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Http\Resources\BusRouteStationResource;

class BusRouteStationController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $response = BusRouteStation::all();
        return response(['buses' => BusRouteStationResource::collection($response), 'message' => 'Retrieved successfully'], 200);
    }

    /**
     * Store a newly created resource in storage.
     * @todo 
     * check both stationId and busRouteId is unique. 
     * Now will return duplicate entry error from db
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $data = $request->all();

        $validator = Validator::make($data, [
            'stationId' => 'required|numeric',
            'busRouteId' => 'required|numeric',
            'status' => 'numeric'
        ]);

        if ($validator->fails()) {
            return response(['error' => $validator->errors(), 'Validation Error']);
        }

        $response = BusRouteStation::create($data);

        return response(['busRouteStations' => new BusRouteStationResource($response), 'message' => 'Created successfully'], 201);
    }
}

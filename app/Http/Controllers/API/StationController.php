<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Station;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Http\Resources\StationResource;

class StationController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $projects = Station::paginate();
        return response(['data' => StationResource::collection($projects), 'message' => 'Retrieved successfully'], 200);
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
            'stationCode' => 'required|max:255|unique:stations',
            'name' => 'required|max:255|unique:stations',
            'lat' => 'required|max:255',
            'lon' => 'required|max:255',
            'status' => 'numeric',
        ]);

        if ($validator->fails()) {
            return response(['error' => $validator->errors(), 'Validation Error']);
        }

        $project = Station::create($data);

        return response(['data' => new StationResource($project), 'message' => 'Created successfully'], 201);
    }
    public function search(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string',
        ]);
        if ($validator->fails()) {
            return response(['errors' => $validator->errors()->all()], 422);
        }
        $response = Station::where('name','like', "%{$request['name']}%")->paginate();
        return response(['data' => StationResource::collection($response), 'message' => 'Retrieved successfully'], 200);
    }
}

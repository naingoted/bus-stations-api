<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Repositories\Interfaces\StationRepositoryInterface;

class StationController extends Controller
{
    private $stationRepository;

    public function __construct(StationRepositoryInterface $stationRepository)
    {
        $this->stationRepository = $stationRepository;
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return $this->stationRepository->all();
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

        return $this->stationRepository->create($data);
    }

    
    public function search(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string',
        ]);
        if ($validator->fails()) {
            return response(['errors' => $validator->errors()->all()], 422);
        }

        return $this->stationRepository->search(['name'=>$request['name']])->paginate();

        // $response = Station::where('name','like', "%{$request['name']}%")->paginate();
        // return response(['data' => StationResource::collection($response), 'message' => 'Retrieved successfully'], 200);
    }
}

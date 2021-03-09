<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Repositories\Interfaces\BusRouteRepositoryInterface;

class BusRouteController extends Controller
{
    private $busRouteRepository;

    public function __construct(BusRouteRepositoryInterface $busRouteRepository )
    {
        $this->busRouteRepository = $busRouteRepository;
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return $this->busRouteRepository->all();
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
            'routeId' => 'required|numeric',
            'busId' => 'required|numeric',
            'status' => 'numeric'
        ]);

        if ($validator->fails()) {
            return response(['error' => $validator->errors(), 'Validation Error']);
        }

        return $this->busRouteRepository->create($data);
    }
}

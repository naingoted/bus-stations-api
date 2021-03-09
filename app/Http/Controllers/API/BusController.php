<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Repositories\Interfaces\BusRepositoryInterface;

class BusController extends Controller
{
    private $busRepository;

    public function __construct(BusRepositoryInterface $busRepository)
    {
        $this->busRepository = $busRepository;
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return $this->busRepository->paginate();
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

        return $this->busRepository->createBusWithRouteAndStation($data);
    }
}

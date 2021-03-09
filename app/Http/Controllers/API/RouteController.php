<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use App\Repositories\Interfaces\RouteRepositoryInterface;

class RouteController extends Controller
{
    private $routeRepository;

    public function __construct(RouteRepositoryInterface $routeRepository)
    {
        $this->routeRepository = $routeRepository;
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return $this->routeRepository->all();
    }
    
    public function search(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string',
        ]);
        if ($validator->fails()) {
            return response(['errors' => $validator->errors()->all()], 422);
        }
        return $this->routeRepository->search(['name'=>$request['name']])->paginate();

        // $response = Route::where('name','like', "%{$request['name']}%")->paginate();
        // return response(['data' => RouteResource::collection($response), 'message' => 'Retrieved successfully'], 200);
    }
}

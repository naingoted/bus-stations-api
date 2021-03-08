<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\RouteResource;
use App\Models\Route;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;

class RouteController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $response = Route::paginate();
        return response(['data' => RouteResource::collection($response), 'message' => 'Retrieved successfully'], 200);
    }
    public function search(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string',
        ]);
        if ($validator->fails()) {
            return response(['errors' => $validator->errors()->all()], 422);
        }
        $response = Route::where('name','like', "%{$request['name']}%")->paginate();
        return response(['data' => RouteResource::collection($response), 'message' => 'Retrieved successfully'], 200);
    }
}

<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\API\AuthController;
use App\Http\Controllers\API\ProjectController;
use App\Http\Controllers\API\StationController;
use App\Http\Controllers\API\BusController;
use App\Http\Controllers\API\BusRouteController;
use App\Http\Controllers\API\BusRouteStationController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/


Route::group(['middleware' => ['cors', 'json.response']], function () {
    // public routes
    Route::prefix('v1')->group(function () {
        Route::post('register', [AuthController::class, 'register']);
        Route::post('login', [AuthController::class, 'login']);
        Route::middleware('auth:api')->group(function () {
            Route::post('logout', [AuthController::class, 'logout']);
            Route::apiResource('projects', ProjectController::class);
            Route::apiResource('stations', StationController::class);
            Route::apiResource('buses', BusController::class);
            Route::apiResource('busRoutes', BusRouteController::class);
            Route::apiResource('busRouteStations', BusRouteStationController::class);
        });
    });
});

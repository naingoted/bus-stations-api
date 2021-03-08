<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\API\AuthController;
use App\Http\Controllers\API\StationController;
use App\Http\Controllers\API\UserController;
use App\Http\Controllers\API\BusController;
use App\Http\Controllers\API\BusRouteController;
use App\Http\Controllers\API\BusRouteStationController;
use App\Http\Controllers\API\LocateBusStopController;
use App\Http\Controllers\API\RouteController;

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
        Route::apiResource('users', UserController::class);
        Route::middleware('auth:api')->group(function () {
            Route::post('busStopNearMe', [LocateBusStopController::class, 'getBusStopNearBy']);
            Route::post('busListByStationId', [LocateBusStopController::class, 'getBusListByBusStop']);
            Route::post('logout', [AuthController::class, 'logout']);
            Route::apiResource('routes', RouteController::class);
            Route::post('searchRoutes', [RouteController::class, 'search']);
            Route::post('searchStations', [StationController::class, 'search']);
            Route::apiResource('stations', StationController::class);
            Route::apiResource('buses', BusController::class);
            Route::apiResource('busRoutes', BusRouteController::class);
            Route::apiResource('busRouteStations', BusRouteStationController::class);
        });
    });
});

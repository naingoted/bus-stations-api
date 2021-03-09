<?php namespace App\Repositories\Interfaces;

use Illuminate\Http\Request;

interface StationRepositoryInterface
{
    public function findNearByStation(Request $request);
}
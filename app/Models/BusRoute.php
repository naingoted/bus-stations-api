<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BusRoute extends Model
{
    use HasFactory;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'routeId',
        'busId',
        'status',
    ];

    public function busRouteStation() {
        return $this->hasMany('\App\Models\BusRouteStation','busRouteId','id');
    }
}

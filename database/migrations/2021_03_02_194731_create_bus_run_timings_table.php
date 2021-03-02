<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBusRunTimingsTable extends Migration
{
    /**
     * Run the migrations.
     * @todo 
     * @return void
     */
    public function up()
    {
        Schema::create('bus_run_timings', function (Blueprint $table) {
            $table->id();
            $table->foreignId('busRouteStationId');
            $table->time('eta', $precision = 0);
            $table->time('etd', $precision = 0);
            $table->timestamps();
            $table->foreign('busRouteStationId')->references('id')->on('bus_route_stations');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('bus_run_timings');
    }
}

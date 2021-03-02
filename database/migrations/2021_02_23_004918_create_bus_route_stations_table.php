<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBusRouteStationsTable extends Migration
{
    /**
     * Run the migrations.
     * @todo relationship with station table
     * @return void
     */
    public function up()
    {
        Schema::create('bus_route_stations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('busRouteId');
            $table->foreignId('stationId');
            $table->integer('status')->default(1);
            $table->timestamps();
            $table->unique(['busRouteId', 'stationId']);
            $table->foreign('busRouteId')->references('id')->on('bus_routes');
            $table->foreign('stationId')->references('id')->on('stations');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('bus_route_stations');
    }
}

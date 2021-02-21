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
            $table->string('busRouteId',255);
            $table->string('stationId',255);
            $table->integer('status')->default(1);
            $table->timestamps();
            $table->unique(['busRouteId', 'stationId']);
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

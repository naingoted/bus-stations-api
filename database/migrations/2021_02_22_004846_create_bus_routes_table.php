<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBusRoutesTable extends Migration
{
    /**
     * Run the migrations.
     * @todo relationship with bus table and make id,busId unique
     * @return void
     */
    public function up()
    {
        Schema::create('bus_routes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('routeId');
            $table->foreignId('busId');
            $table->timestamps();
            $table->foreign('routeId')->references('id')->on('routes');
            $table->foreign('busId')->references('id')->on('buses');
            $table->unique(['routeId', 'busId']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('bus_routes');
    }
}

<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        \App\Models\User::factory(10)->create();
        // \App\Models\Bus::factory(10)->create();
        // \App\Models\Route::factory(10)->create();
        // \App\Models\BusRoute::factory(10)->create();
        // \App\Models\Station::factory(10)->create();
        // \App\Models\BusRouteStation::factory(10)->create();
        // \App\Models\BusRunTiming::factory(10)->create();
    }
}

<?php

namespace Database\Factories;

use App\Models\BusRouteStation;
use Illuminate\Database\Eloquent\Factories\Factory;

class BusRouteStationFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = BusRouteStation::class;

    /**
     * Define the model's default state.
     * singapore lat 1.44 - 1.29
     * singapore long 103.85 - 103.82
     * @return array
     */
    public function definition()
    {
        return [
            'busRouteId' => $this->faker->biasedNumberBetween($min = 1, $max = 10, $function = 'sqrt'),
            'busStationId' => $this->faker->biasedNumberBetween($min = 1, $max = 10, $function = 'sqrt')
        ];
    }
}

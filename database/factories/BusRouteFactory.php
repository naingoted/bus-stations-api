<?php

namespace Database\Factories;

use App\Models\BusRoute;
use Illuminate\Database\Eloquent\Factories\Factory;

class BusRouteFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = BusRoute::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'routeId' => $this->faker->biasedNumberBetween($min = 1, $max = 10, $function = 'sqrt'),
            'busId' => $this->faker->biasedNumberBetween($min = 1, $max = 10, $function = 'sqrt'),
        ];
    }
}

<?php

namespace Database\Factories;

use App\Models\Station;
use Illuminate\Database\Eloquent\Factories\Factory;

class StationFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Station::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'stationCode' => $this->faker->unique()->postcode,
            'name' => $this->faker->unique()->streetName,
            'lat' => $this->faker->unique()->latitude($min = 1.29, $max = 1.44),
            'lon' => $this->faker->unique()->longitude($min = 103.82, $max = 103.85)        
        ];
    }
}

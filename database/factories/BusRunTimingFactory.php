<?php

namespace Database\Factories;

use App\Models\BusRunTiming;
use Illuminate\Database\Eloquent\Factories\Factory;

class BusRunTimingFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = BusRunTiming::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'busRouteStationId' => $this->faker->biasedNumberBetween($min = 1, $max = 10, $function = 'sqrt'),
            'eta' => $this->faker->dateTimeBetween($startDate = 'now', $endDate = '+15 minutes', $timezone = null),
            'etd' => $this->faker->dateTimeBetween($startDate = 'now', $endDate = '+5 minutes', $timezone = null)
        ];
    }
}

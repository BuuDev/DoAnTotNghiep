<?php

namespace Database\Factories;

use App\Models\Doctors;
use Illuminate\Database\Eloquent\Factories\Factory;

class DoctorsFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Doctors::class;


    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'status' => 'active',
            'location' => '{"latitude":"10.973442810909694","longitude":"106.65944058131788"}',
            'website' => 'http://thammydonga.vn',
            'phone' => '03'.random_int(10000000,99999999),
            'image' => '/upload/doctors/1647403491_1_3.jpg',
            'rating' => null,
            'hashtag' => null,
            'type' => 'doctor',
        ];
    }
}

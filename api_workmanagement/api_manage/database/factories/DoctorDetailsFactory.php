<?php

namespace Database\Factories;

use App\Models\DoctorDetails;
use App\Models\Doctors;
use Illuminate\Database\Eloquent\Factories\Factory;
use Faker\Generator as Faker;

class DoctorDetailsFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = DoctorDetails::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        $rand = random_int(1, 2);
        if ($rand == 1) {
            return [
                'doctor_id' => Doctors::all()->random()->id,
                'name' => $this->faker->name(),
                'address' => $this->faker->address(),
                'work_place' => $this->faker->address(),
                'experience' => random_int(1, 10),
                'unit' => 'year',
                'specialize' => '<p><strong>Địa chỉ</strong></p><p>85 âu cơ tân bình tp hcm</p><p><strong>Chuyên môn </strong></p><p><em>ÂCCACACACAC</em></p><p><br></p>',
                'description' => null,
                'language' => 'vn',
                'price' => random_int(1000, 99999999),
                'currency' => 'VND',
            ];
        } else {
            return [
                'doctor_id' => Doctors::all()->random()->id,
                'name' => $this->faker->name(),
                'address' => $this->faker->address(),
                'work_place' => $this->faker->address(),
                'experience' => random_int(1, 10),
                'unit' => 'year',
                'specialize' => '<p>Detailed information about Spa:</p><p><br></p><p>-The experienced team of doctors</p>',
                'description' => null,
                'language' => 'en',
                'price' => random_int(1000, 99999999),
                'currency' => 'VND',
            ];
        }
    }
}

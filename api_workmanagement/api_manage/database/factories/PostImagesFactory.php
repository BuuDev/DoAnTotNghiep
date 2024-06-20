<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

use App\Models\PostImages;
class PostImagesFactory extends Factory
{
    protected $model = PostImages::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'url' => '/analysis-images/1/1_31032022093108.jpg',
            'type' =>  null,
            'name' =>  $this->faker->name(),
            'post_id' => rand(1,100),
        ];
    }
}

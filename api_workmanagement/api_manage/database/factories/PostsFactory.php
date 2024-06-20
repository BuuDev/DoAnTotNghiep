<?php

namespace Database\Factories;

use App\Models\Posts;
use Illuminate\Database\Eloquent\Factories\Factory;

class PostsFactory extends Factory
{
    protected $model = Posts::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'user_id' => 1, 
            'thumbnail' => '/analysis-images/1/1_31032022093108.jpg',
            'status' => 'active',
            'type' => 'cosmetics',
            'agree' => true
      ];
    }
}

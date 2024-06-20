<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\PostDetails;

class PostDetailsFactory extends Factory
{
    protected $model = PostDetails::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
            $i=rand(1,2);
            if($i == 1)
            {
                return [
                    'post_id' =>  rand(1,100),
                    'title' => 'Top 10 kem dưỡng ẩm không dàu tốt cho da nhờn mụn',
                   
                    'content' => "Top 10 kem dưỡng ẩm không dầu tốt nhất dành cho da nhờn mụn
                    23 tháng 4, 2021
                    Dòng kem dưỡng ẩm không dầu giống như một 'cốc sinh tố' cho da. Chúng giúp bạn cấp nước nhưng lại không làm da mặt bị bóng dầu, nhờn dính.
                    Dầu tiết tự nhiên trên da có công dụng dưỡng ẩm. Nhưng nếu có quá nhiều dầu, bạn sẽ bị nổi mụn. Đó là lý do tại sao bạn cần kem dưỡng ẩm không chứa dầu để đảm bảo da được chăm sóc đầy đủ và không phải chịu thêm gánh nặng về dầu.
                    
                    Dầu tiết tự nhiên trên da có công dụng dưỡng ẩm. Nhưng nếu có quá nhiều dầu, bạn sẽ bị nổi mụn. Đó là lý do tại sao bạn cần kem dưỡng ẩm không chứa dầu để đảm bảo da được chăm sóc đầy đủ và không phải chịu thêm gánh nặng về dầu.
                    
                    Dầu tiết tự nhiên trên da có công dụng dưỡng ẩm. Nhưng nếu có quá nhiều dầu, bạn sẽ bị nổi mụn. Đó là lý do tại sao bạn cần kem dưỡng ẩm không chứa dầu để đảm bảo da được chăm sóc đầy đủ và không phải chịu thêm gánh nặng về dầu.",
                   
                    'language' => 'vn',
                    'description'  =>'<p>HIỂU VỀ MỤN TRỨNG CÁ</p>'
                    ];
            }
            else{
                return [
                    'post_id' =>  rand(1,100),
                    'title' => 'Top 10 good oil-free moisturizers for wet skin',
                   
                    'content' => "Top 10 best oil-free moisturizers for acne-prone skin
                    April 23, 2021
                    The oil-free moisturizer line is like a 'smoothie cup' for the skin. They help you hydrate but don't make your face greasy or sticky.
                    The skin's natural oils have a moisturizing effect. But if there's too much oil, you'll get pimples. That's why you need an oil-free moisturizer to make sure your skin is fully cared for and doesn't have to be burdened with extra oil.
                    
                    The natural oils on the skin have a moisturizing effect. But if there's too much oil, you'll get pimples. That's why you need an oil-free moisturizer to make sure your skin is fully cared for and doesn't have to be burdened with extra oil.
                    
                    The skin's natural oils have a moisturizing effect. But if there's too much oil, you'll get pimples. That's why you need an oil-free moisturizer to make sure your skin is fully cared for and doesn't have to be burdened with extra oil.",
                   
                    'language' => 'en',
                    'description'  =>'<p>UNDERSTANDING CASE HEAD</p>'
                    ];
            }
        }
}

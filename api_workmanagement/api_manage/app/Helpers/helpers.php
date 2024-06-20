<?php
namespace App\Helpers;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Storage;
use Image;
class HelperSkin{

    public static function responseFormat ($success, $message, $data = null, $code = null) {
        if(!empty($code)){
            return response()->json([
                'success' => $success,
                'message'   => $message,
                'data'   => $data,
            ],$code);
        }

        if($success == true){
            return response()->json([
                'success' => $success,
                'message'   => $message,
                'data'   => $data,
            ],200);
        }

        return response()->json([
            'success' => $success,
            'message'   => $message,
            'data'   => $data,
        ],400);

        
    }

    public static function uploadImg ($img, $folder, $name = null) {
        // date_default_timezone_set('Asia/Ho_Chi_Minh');
        $user_id = Auth::user()->id;
    
        $file_name = $img->getClientOriginalName();
        $arr = explode('.', $file_name);
        // $extension = $arr[count($arr)-1];
        $extension = end($arr);
        $path = public_path($folder);

        if(!file_exists($path)){
            File::makeDirectory($path, 0777, true);
        }
        if($name == null){
            $new_name = $user_id."_".date("dmYhis").".".$extension;
        }else{
            $new_name = $name;
        }
        // dd(getimagesize($img));

        //resize img
        $img = Image::make($img->path());
        $img->save($path.'/'.$new_name);
       
        // dd(getimagesize(public_path($folder.'/'.$new_name)));

        // $img->move($path, $new_name);
        ////

        // $img->move($path,$new_name);
        
        return $folder.'/'.$new_name;
    }

    public static function uploadImg_Analysis ($img, $folder, $name = null) {
        // date_default_timezone_set('Asia/Ho_Chi_Minh');
        $user_id = Auth::user()->id;
    
        $file_name = $img->getClientOriginalName();
        $arr = explode('.', $file_name);
        // $extension = $arr[count($arr)-1];
        $extension = end($arr);
        $path = public_path($folder);

        if(!file_exists($path)){
            File::makeDirectory($path, 0777, true);
        }
        if($name == null){
            $new_name = $user_id."_".date("dmYhis").".".$extension;
        }else{
            $new_name = $name;
        }
        // dd(getimagesize($img));
      
        //resize img
        $img = Image::make($img->getRealpath());
        $img->orientate();

        $height_org = Image::make($img)->height();
        $width_org = Image::make($img)->width();

        $resizeWidth = 768;
        $ratio = $resizeWidth / $width_org;
        $resizeHeight = $ratio * $height_org;
        
        # store original image
        $img->resize(768,$resizeHeight)->save("{$path}/{$new_name}");
        // dd(getimagesize(public_path($folder.'/'.$new_name)));

        // $img->move($path, $new_name);
        ////

        // $img->move($path,$new_name);
        
        return "{$folder}/{$new_name}";  
    }

    public static function deleteImg($url) {
        // $path = $folder. '/'. $img;
        // if (file_exists($path)) {
        //     Storage::disk('public')->delete($path);
        // }
        $url = substr($url,1);
        if (file_exists($url)) {
           unlink($url);
        }
    }
    public static function distance($latitude1, $longitude1, $latitude2, $longitude2)
    {
        // $latitude1  =  9.808010;
        // $longitude1  =  105.668600;
        // $latitude2  =  9.770036;
        // $longitude2  =  105.617294;
        $longi1  =  deg2rad($longitude1);
        $longi2  =  deg2rad($longitude2);
        $lati1  =  deg2rad($latitude1);
        $lati2  =  deg2rad($latitude2);
        $difflong  =  $longi2  -  $longi1;
        $difflat  =  $lati2  -  $lati1;
        $val  =  pow(sin($difflat / 2), 2) + cos($lati1) * cos($lati2) * pow(sin($difflong / 2), 2);
        $res  = 6378.8  *  (2  *  asin(sqrt($val)));
        //return kilometer
        return $res;
    }

}
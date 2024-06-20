<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\SoftDeletes;
use Tymon\JWTAuth\Contracts\JWTSubject;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Spatie\Permission\Traits\HasRoles; 


class User extends Authenticatable implements JWTSubject

{
    use HasApiTokens, HasFactory, SoftDeletes, Notifiable,HasRoles;


    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'code',
        'fullname',
        'username',
        'password',
        'birthday',
        'citizen_identification',
        'email',
        'phone',
        'address',
        'role_id',
        'department_id',
    ];

    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'otp', 'api_token', 'expired_time'
    ];
    public function guardName(){
        return "api";
    }
    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    public function getJWTCustomClaims()
    {
        return [];
    }
    public function getAvatarAttribute($value)
    {
        if ($value != null) {
            // return  $this->image=url($value);
            return $this->avatar = url($value);
        }
    }

    public function devices(){
        return $this->hasMany(Notification::class, 'user_id', 'id');
    }

   
    public function role()
    {
        return $this->belongsTo(Role::class);
    }

    public function scopeQueryData($query, $req)
    {      
        if (!empty($req['fullname'])) {
            $arr_fullname = json_decode($req['fullname']);
            if (is_array($arr_fullname) && !empty($arr_fullname)) {
               $query->whereIn('fullname', $arr_fullname); 
            } 
        };

        if (!empty($req['phone'])) {
            $arr_phone = json_decode($req['phone']);
            if (is_array($arr_phone) && !empty($arr_phone)) {
               $query->whereIn('phone', $arr_phone); 
            } 
        };

        if (!empty($req['role_id'])) {
            $arr_role = json_decode($req['role_id']);
            if (is_array($arr_role) && !empty($arr_role)) {
               $query->whereIn('role_id', $arr_role); 
            } 
        };
        return $query;
    }
}

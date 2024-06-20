<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Auth\Middleware\Authenticate as Middleware;
use Illuminate\Support\Facades\Auth;

class Authenticate extends Middleware
{
    /**
     * Get the path the user should be redirected to when they are not authenticated.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return string|null
     */
    protected function redirectTo($request)
    {
        // if (! $request->expectsJson()) {
        //     return route('login');
        // }
    }
    protected function authenticate($request, array $guards)
    {
        if(empty($guards)){
            $guards = [null];
        }

        foreach($guards as $guard){
            if($this->auth->guard($guard)->check()){
                return $this->auth->shouldUse($guard);
            }
        }

        return 'authentication_error';
    }

    public function handle($request, Closure $next, ...$guards)
    {
        if($this->authenticate($request, $guards) === 'authentication_error'){
            return response()->json(['success' => false, 'message' => 'Unauthorized'], 401);
        }

        if(Auth::user()->active == 0){
            return response()->json(['success' => false, 'message' => 'Unauthorized'], 401);
        }

        return $next($request);
    }
}

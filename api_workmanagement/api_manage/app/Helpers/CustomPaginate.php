<?php
namespace App\Helpers;

use Illuminate\Container\Container;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Pagination\Paginator;
use Illuminate\Support\Collection;

class CustomPaginate{

    public static function paginate(Builder $results, $page, $perPage)
    {
        $total = $results->count();
        $page = (int)$page;
        $perPage = (int)$perPage;
        $totalPage = ceil($total / $perPage);
        $result = $results->offset(($page-1)*$perPage)->limit($perPage)->orderBy('created_at', 'desc')->get();
        if($result->isEmpty()){
            return array('data' => []);
        }
        return [
            'data' => $result,
            'currentPage' => $page,
            'perPage' => $perPage,
            'total' => $total,
        ];
    }

}
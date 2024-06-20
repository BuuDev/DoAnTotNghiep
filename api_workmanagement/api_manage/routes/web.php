<?php

use App\Http\Controllers\DepartmentController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\ContactController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\AnnualLeaveController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

// Route::get('/', function () {
//     return view('welcome');
// });

Route::get('/', function () {
    return view('doc');
});


Route::group([
    'middleware' => 'api',
    'prefix' => 'v2'

], function ($router) {
    Route::post('/demo', function(){
        return 'demo';
    });

    Route::post('/login', [UserController::class, 'login']);
    //User
    Route::get('listUser', [UserController::class, 'listUser']);
    Route::post('user/create', [UserController::class, 'createUser']);
    Route::post('user/update', [UserController::class, 'updateUser']);
    Route::post('user/delete', [UserController::class, 'deleteUser']);
    //Phòng ban
    Route::get('listDepartment', [DepartmentController::class, 'listDepartmentr']);
    Route::post('department/create', [DepartmentController::class, 'createDepartment']);
    Route::post('department/update', [DepartmentController::class, 'updateDepartment']);
    Route::post('department/delete', [DepartmentController::class, 'deleteDepartment']);
    //Quyền
    Route::get('listRole', [RoleController::class, 'listRole']);
    Route::post('Role/create', [RoleController::class, 'createRole']);
    Route::post('Role/update', [RoleController::class, 'updateRole']);
    Route::post('Role/delete', [RoleController::class, 'deleteRole']);

    //quản lí hợp đồng

    Route::get('listContact', [ContactController::class, 'listContact']);
    Route::get('listContractIsAboutToExpire', [ContactController::class, 'listContractIsAboutToExpire']);
    Route::post('Contact/create', [ContactController::class, 'createContact']);
    Route::post('Contact/update', [ContactController::class, 'updateContact']);
    Route::post('Contact/delete', [ContactController::class, 'deleteContact']);

    //Nghỉ phép

    Route::get('listAnnualLeave', [AnnualLeaveController::class, 'listAnnualLeave']);
    Route::get('waitingListForApproval', [AnnualLeaveController::class, 'waitingListForApproval']);

    Route::post('AnnualLeave/create', [AnnualLeaveController::class, 'createAnnualLeave']);
    Route::post('AnnualLeave/update', [AnnualLeaveController::class, 'updateAnnualLeave']);
    Route::post('AnnualLeave/delete', [AnnualLeaveController::class, 'deleteAnnualLeave']);
    Route::post('AnnualLeave/approve', [AnnualLeaveController::class, 'approveAnnualLeave']);

    
    ///
    Route::group(['middleware' => 'auth:api'], function () use ($router) {
        Route::pattern('id', '[0-9]+');
        Route::post('logout', [UserController::class, 'logout']);
        

        
    });
});


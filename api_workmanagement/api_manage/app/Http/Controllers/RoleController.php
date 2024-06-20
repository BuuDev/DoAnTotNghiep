<?php

namespace App\Http\Controllers;

use App\Models\Role;
use App\Models\Role_has_permission;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Spatie\Permission\Models\Permission;
use App\Models\Model_has_role;
use Spatie\Permission\Models\Role as ModelsRole;
use App\Helpers\HelperSkin;

class RoleController extends Controller
{
   
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
     /**
     * @OA\Get(
     *     path="/v2/listRole",
     *     tags={"Role"},
     *     @OA\Parameter(
     *         name="paginate",
     *         description="if filed paginate null then paginate default = 10",
     *         in="query",
     *         required=false,
     *         @OA\Schema(type="integer")
     *     ),
     *     @OA\Parameter(
     *         name="page",
     *         description="if filed paginate null then paginate default = 1",
     *         in="query",
     *         required=false,
     *         @OA\Schema(type="integer")
     *     ),
     *     @OA\Response(
     *          response=200,
     *          description="Successful operation",
     *      ),
     *      @OA\Response(
     *          response=401,
     *          description="Unauthorized",
     *      ),
     *      @OA\Response(
     *          response=500,
     *          description="Error server",
     *      ),
     *      security={
     *          {"bearerAuth": {}}
     *      }
     * )
     */
    public function listRole()
    {
        $role = Role::with('listPermission')->get();
        $permission = Permission::all();

        if (empty($role)) {
           
            return HelperSkin::responseFormat(true, 'Danh sách trống');
        } 
      return response()->json([
                'success' => true,
                'message'   => 'Danh sách Phòng ban',
                'role'  =>$role,
                'permission'  =>$permission,
            ],400);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
 

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */

    /**
     * @OA\post(
     *     path="/v2/Role/create",
     *     tags={"Role"},
     * @OA\Parameter(
     *         name="name",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ),
     *  @OA\Parameter(
     *         name="permission_id",
     *         description="1,2,3....",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ),
     * @OA\Response(
     *          response=200,
     *          description="Successful operation",
     *      ),
     *      @OA\Response(
     *          response=401,
     *          description="Unauthorized",
     *      ),
     *      @OA\Response(
     *          response=500,
     *          description="Error server",
     *      ),
     *      security={
     *          {"bearerAuth": {}}
     *      }
     * )
     */
    public function createRole(Request $request)
    {
        // dd($request->name);
        $validator = Validator::make(
            $request->all(),
            [
                'name' =>  "required|unique:Spatie\Permission\Models\Role,name, {$request->id},id",
            ],
            [
                'name.unique' => 'Tên quyền đã tồn tại',
                'name.required' => 'Tên quyền không được trống',
            ]
        );
        if ($validator->fails()) {
            return response()->json([
                'status' => 'warning',
                'message' => $validator->messages()->first(),
            ], 200);
        }

        $role = ModelsRole::create(['name' => $request->name]);
        $permissions = explode(',',$request->permission_id);
        foreach ($permissions as $permission_id) {
            $permission = Permission::find($permission_id);
            $permission->assignRole($role);
        }
        $role = Role::where('id',$role->id)->with('listPermission')->get();
        return HelperSkin::responseFormat(true, 'Thêm thành công', $role);
 
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

  

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */

       /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
/**
     * @OA\post(
     *     path="/v2/Role/update",
     *     tags={"Role"},
     * @OA\Parameter(
     *         name="id",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="integer")
     *     ),
     * @OA\Parameter(
     *         name="permission_id",
     *         description="1,2,3....",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ),
     * @OA\Response(
     *          response=200,
     *          description="Successful operation",
     *      ),
     *      @OA\Response(
     *          response=401,
     *          description="Unauthorized",
     *      ),
     *      @OA\Response(
     *          response=500,
     *          description="Error server",
     *      ),
     *      security={
     *          {"bearerAuth": {}}
     *      }
     * )
     */
  
    public function updateRole(Request $request)
    {

        $ModelsRole = ModelsRole::find($request->id);
        $role = Role::find($request->id);
        if(empty($role))
        {
            return HelperSkin::responseFormat(true, 'Không tìm thấy phân quyền này');
        }
        $listPermisons = explode(",", $request->permission_id);

        foreach ($role->listPermission as $delete_permission) {
            $ModelsRole->revokePermissionTo($delete_permission);
        }

        foreach ($listPermisons as $id) {
            $permission = Permission::find($id);
            $perminssionInRolle = $permission->assignRole($ModelsRole);
        }
        $role = Role::where('id',$role->id)->with('listPermission')->get();

        return HelperSkin::responseFormat(true, 'Update thành công', $role);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */

     /**
     * @OA\post(
     *     path="/v2/Role/delete",
     *     tags={"Role"},
     * @OA\Parameter(
     *         name="id",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="integer")
     *     ),
     * @OA\Response(
     *          response=200,
     *          description="Successful operation",
     *      ),
     *      @OA\Response(
     *          response=401,
     *          description="Unauthorized",
     *      ),
     *      @OA\Response(
     *          response=500,
     *          description="Error server",
     *      ),
     *      security={
     *          {"bearerAuth": {}}
     *      }
     * )
     */
    public function deleteRole(Request $request)
    {
        $ModelsRole = ModelsRole::find($request->id);
        $role = Role::where('id',$request->id)->first();
        if(empty($role))
        {
            return HelperSkin::responseFormat(true, 'Không tìm thấy phân quyền này');
        }

        foreach ($role->listPermission as $delete_permission) {
            $ModelsRole->revokePermissionTo($delete_permission);
        }
        $role = $role->delete();
          if ($role) {
              return HelperSkin::responseFormat(true, 'Xoá thành công');
          } 
          return HelperSkin::responseFormat(true, 'Xoá thất bại');

    }

  

}

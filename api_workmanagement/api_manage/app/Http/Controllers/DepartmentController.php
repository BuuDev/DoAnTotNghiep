<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Department;
use Illuminate\Support\Facades\Validator;
use App\Helpers\HelperSkin;

class DepartmentController extends Controller
{
    public function __construct()
    {
        $this->module = 'department';
        $this->breadcrumb = [
            'object'    => 'Phòng ban',
            'page'      => ''
        ];
        $this->title = 'Phòng ban';
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    /**
     * @OA\Get(
     *     path="/v2/listDepartment",
     *     tags={"Department"},
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
    public function listDepartmentr()
    {
        $departments = Department::all();
        if (empty($departments)) {
           
            return HelperSkin::responseFormat(true, 'Danh sách trống');
        } 
        return HelperSkin::responseFormat(true, 'Danh sách Phòng ban',$departments);

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
     *     path="/v2/department/create",
     *     tags={"Department"},
     * @OA\Parameter(
     *         name="name",
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
    public function createDepartment(Request $request)
    {
        $validator = Validator::make(
            $request->all(),
            [
                'name' => 'required|unique:App\Models\Department,name',

            ],
            [
                'name.unique' => 'Tên phòng ban đã tồn tại',
                'name.required' => 'Tên phòng ban không được trống',
            ]
        );
        if ($validator->fails()) {
            return response()->json([
                'status' => 'warning',
                'message' => $validator->messages()->first(),
            ], 200);
        }
        $newDepartment = Department::create([
            'name' => $request->name
        ]);
        if ($newDepartment) {
            return HelperSkin::responseFormat(true, 'Thêm thành công', $newDepartment);
        } 
        return HelperSkin::responseFormat(true, 'Thêm thất bại');
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
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
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
     * @OA\post(
     *     path="/v2/department/update",
     *     tags={"Department"},
     *   @OA\Parameter(
     *         name="id",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="integer")
     *     ),
     * @OA\Parameter(
     *         name="name",
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
    public function updateDepartment(Request $request)
    {
        $validator = Validator::make(
            $request->all(),
            [
                'name' => 'required|unique:App\Models\Department,name,' . $request->id,

            ],
            [
                'name.unique' => 'Tên phòng ban đã tồn tại',
                'name.required' => 'Tên phòng ban không được trống',
            ]
        );
        if ($validator->fails()) {
            return response()->json([
                'status' => 'warning',
                'message' => $validator->messages()->first(),
            ], 200);
        }
        $department = Department::find($request->id);

        if (!empty($department)) {
            $department->name = $request->name;
            $department->save();
            return HelperSkin::responseFormat(true, 'Update thành công', $department);
        } else {
            return HelperSkin::responseFormat(true, 'Không tìm thấy phòng ban này');

        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
      /**
     * @OA\post(
     *     path="/v2/department/delete",
     *     tags={"Department"},
     *   @OA\Parameter(
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
    public function deleteDepartment(Request $request)
    {
          $Department = Department::destroy($request->id);
          if(empty($Department))
          {
            return HelperSkin::responseFormat(true, 'Không tìm thấy phòng ban này');
          }
            if ($Department) {
                return HelperSkin::responseFormat(true, 'Xoá thành công');
            } 
            return HelperSkin::responseFormat(true, 'Xoá thất bại');
    }
}

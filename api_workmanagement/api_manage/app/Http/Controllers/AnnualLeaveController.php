<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Carbon\Carbon;
use App\Models\User;
use App\Models\AnnualLeave;
use Illuminate\Support\Facades\Validator;
use App\Helpers\HelperSkin;

class AnnualLeaveController extends Controller
{
   /**
     * @OA\Get(
     *     path="/v2/listAnnualLeave",
     *     tags={"AnnualLeaves"},
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
    public function listAnnualLeave()
    {
        $user = User::all();
        $annual_leaves  = AnnualLeave::where('status',1)->with(['user'])->get();
        $data = [
            'users'      => $user,
            'annual_leave' => $annual_leaves
        ];

        return response()->json([
            'success' => true,
            'message'   => 'Danh sách nghỉ phép',
            'users'      => $user,
            'annual_leave' => $annual_leaves
        ],400);

    }

    /**
     * @OA\Get(
     *     path="/v2/waitingListForApproval",
     *     tags={"AnnualLeaves"},
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
    public function waitingListForApproval()
    {
        $user = User::all();
        $annual_leaves  = AnnualLeave::where('status',0)->with(['user'])->get();
        $data = [
            'users'      => $user,
            'annual_leave' => $annual_leaves
        ];

        return response()->json([
            'success' => true,
            'message'   => 'Danh sách nghỉ phép',
            'users'      => $user,
            'annual_leave' => $annual_leaves
        ],400);

    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $user = User::all();
        $this->breadcrumb['page'] = 'Thêm mới';
        $data = [
            'users'         => $user,
        ];
        $this->title = 'Thêm mới';
        return $this->openView("modules.{$this->module}.create", $data);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */

      /**
     * @OA\post(
     *     path="/v2/AnnualLeave/create",
     *     tags={"AnnualLeaves"},   
     * @OA\Parameter(
     *         name="start_date",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ),
     *  @OA\Parameter(
     *         name="finish_date",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ),
     *  @OA\Parameter(
     *         name="user_id",
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
    public function createAnnualLeave(Request $request)
    {
        $validator = Validator::make(
            $request->all(),
            [
                'start_date' => 'required',
                'finish_date' => 'required',
                'user_id' => 'required',
            ],
            [
                'start_date.required' => 'Ngày nghĩ từ nghĩ không được trống',
                'finish_date.required' => 'Ngày nghĩ đến nghĩ không được trống',
                'user_id.required'    => 'Nhân viên không được trống',
            ]
        );
        if ($validator->fails()) {
            return response()->json([
                'status' => 'warning',
                'message' => $validator->messages()->first(),
            ], 200);
        }
       $AnnualLeave = AnnualLeave::create(
            [
                'start_date'    => $request->start_date,
                'finish_date'   => $request->finish_date,
                'user_id'       => $request->user_id,
                'total_day'     => Carbon::parse($request->finish_date)->diffInDays(Carbon::parse($request->start_date)) + 1,
                'status'        => 0
            ]
        );
        if($AnnualLeave)
       {
        return HelperSkin::responseFormat(true, 'Thêm thành công',$AnnualLeave);
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
        $user = User::all();
        $annual_leave = AnnualLeave::find($id);
        $this->breadcrumb['page'] = 'Cập nhật';
        $data = [
            'users'         => $user,
            'annual_leave'  => $annual_leave
        ];
        $this->title = 'Cập nhật';
        return $this->openView("modules.{$this->module}.update", $data);
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
     *     path="/v2/AnnualLeave/update",
     *     tags={"AnnualLeaves"},
      *    @OA\Parameter(
     *         name="id",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ),
     * @OA\Parameter(
     *         name="start_date",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ),
     *  @OA\Parameter(
     *         name="finish_date",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ),
     *  @OA\Parameter(
     *         name="user_id",
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
    public function updateAnnualLeave(Request $request)
    {
        $validator = Validator::make(
            $request->all(),
            [
                'start_date' => 'required',
                'finish_date' => 'required',
                'user_id' => 'required',
            ],
            [
                'start_date.required' => 'Ngày nghĩ từ nghĩ không được trống',
                'finish_date.required' => 'Ngày nghĩ đến nghĩ không được trống',
                'user_id.required'    => 'Nhân viên không được trống',
            ]
        );
        if ($validator->fails()) {
            return response()->json([
                'status' => 'warning',
                'message' => $validator->messages()->first(),
            ], 200);
        }
        $annual_leave = AnnualLeave::find($request->id);
        if (!empty($annual_leave)) {
            $annual_leave->start_date = $request->start_date;
            $annual_leave->finish_date = $request->finish_date;
            $annual_leave->user_id = $request->user_id;
            $annual_leave->total_day = Carbon::parse($request->finish_date)->diffInDays(Carbon::parse($request->start_date)) + 1;
            $annual_leave->save();
            if($annual_leave)
            {
             return HelperSkin::responseFormat(true, 'Thêm thành công',$annual_leave);
            }
            return HelperSkin::responseFormat(true, 'Thêm thất bại');
        }
        else{
            return HelperSkin::responseFormat(true, 'Không tìm thấy đơn nghỉ này');
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
     *     path="/v2/AnnualLeave/delete",
     *     tags={"AnnualLeaves"},
      *    @OA\Parameter(
     *         name="id",
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
    public function deleteAnnualLeave(Request $request)
    {
        $delete = AnnualLeave::destroy($request->id);
        if(empty($delete))
        {
          return HelperSkin::responseFormat(true, 'Không tìm thấy đơn nghỉ này');
        }
          if ($delete) {
              return HelperSkin::responseFormat(true, 'Xoá thành công');
          } 
          return HelperSkin::responseFormat(true, 'Xoá thất bại');
    }

    public function customFilterAjax($filter, $columns)
    {
        if (!empty($columns)) {
            foreach ($columns as $column) {
                if ($column["search"]["value"] != null) {
                    $filter[$column["name"]] = $column["search"]["value"];
                }
            }
        }
        return $filter;
    }

    public function loadAjaxListAnnualLeave(Request $request)
    {
        $draw            = $request->get('draw');
        $start           = $request->get("start");
        $rowperpage      = $request->get("length"); // Rows display per page
        $columnIndex_arr = $request->get('order');
        $columnName_arr  = $request->get('columns');
        $order_arr       = $request->get('order');
        $search_arr      = $request->get('search');
        $columnIndex     = $columnIndex_arr[0]['column']; // Column index
        $columnName      = $columnName_arr[$columnIndex]['name']; // Column name
        $columnSortOrder = $order_arr[0]['dir']; // asc or desc
        $searchValue     = trim($search_arr['value']); // Search value
        $filter['search'] =  $searchValue;
        $filter = $this->customFilterAjax($filter, $columnName_arr);
        // Total records
        $totalRecords  = AnnualLeave::where('status',1)->count();
        $totalRecordswithFilter = AnnualLeave::where('status',1)->queryData($filter)->distinct()->count();
        $annual_leave = AnnualLeave::where('status',1)->select(['annual_leaves.*'])
            ->leftjoin('users', 'users.id', '=', 'annual_leaves.user_id')
            ->with(['user'])
            ->queryData($filter)
            ->orderBy($columnName, $columnSortOrder)->distinct()->skip($start)->take($rowperpage)->get();

        $response = [
            "draw"                 => intval($draw),
            "iTotalRecords"        => $totalRecords,
            "iTotalDisplayRecords" => $totalRecordswithFilter,
            "aaData"               => $annual_leave,
            "filter"               => $filter,
        ];
        echo json_encode($response);
        exit;
    }

    public function loadAjaxWaitingListForApproval(Request $request)
    {
        $draw            = $request->get('draw');
        $start           = $request->get("start");
        $rowperpage      = $request->get("length"); // Rows display per page
        $columnIndex_arr = $request->get('order');
        $columnName_arr  = $request->get('columns');
        $order_arr       = $request->get('order');
        $search_arr      = $request->get('search');
        $columnIndex     = $columnIndex_arr[0]['column']; // Column index
        $columnName      = $columnName_arr[$columnIndex]['name']; // Column name
        $columnSortOrder = $order_arr[0]['dir']; // asc or desc
        $searchValue     = trim($search_arr['value']); // Search value
        $filter['search'] =  $searchValue;
        $filter = $this->customFilterAjax($filter, $columnName_arr);
        // Total records
        $totalRecords  = AnnualLeave::where('status',0)->count();
        $totalRecordswithFilter = AnnualLeave::where('status',0)->queryData($filter)->distinct()->count();
        $annual_leave = AnnualLeave::where('status',0)->select(['annual_leaves.*'])
            ->leftjoin('users', 'users.id', '=', 'annual_leaves.user_id')
            ->with(['user'])
            ->queryData($filter)
            ->orderBy($columnName, $columnSortOrder)->distinct()->skip($start)->take($rowperpage)->get();

        $response = [
            "draw"                 => intval($draw),
            "iTotalRecords"        => $totalRecords,
            "iTotalDisplayRecords" => $totalRecordswithFilter,
            "aaData"               => $annual_leave,
            "filter"               => $filter,
        ];
        echo json_encode($response);
        exit;
    }
  /**
     * @OA\post(
     *     path="/v2/AnnualLeave/approve",
     *     tags={"AnnualLeaves"},
      *    @OA\Parameter(
     *         name="id",
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

    public function approveAnnualLeave(Request $request)
    {
        $annual_leave = AnnualLeave::find($request->id);
        if (!empty($annual_leave)) {
            $annual_leave->status = 1;
            $annual_leave->save();

            if($annual_leave)
            {
             return HelperSkin::responseFormat(true, 'Duyệt thành công',$annual_leave);
            }
            return HelperSkin::responseFormat(true, 'Duyệt thất bại');
        }
        else{
            return HelperSkin::responseFormat(true, 'Không tìm thấy đơn nghỉ này');
        }
    }
}

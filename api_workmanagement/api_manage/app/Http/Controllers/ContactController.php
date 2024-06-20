<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Contract;
use App\Models\User;
use Carbon\Carbon;
use App\Models\Salary;
use App\Helpers\HelperSkin;

use Illuminate\Support\Facades\Validator;

class ContactController extends Controller
{
    public function __construct()
    {
        $this->module = 'contracts';
        $this->breadcrumb = [
            'object'    => 'Hợp đồng',
            'page'      => ''
        ];
        $this->title = 'Hợp đồng';
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */

  /**
     * @OA\Get(
     *     path="/v2/listContact",
     *     tags={"Contacts"},
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
    public function listContact()
    {
        $user = User::all();
        $salary = Salary::all();
        $Contract = Contract::with(['user'])->with(['salary'])->get();

        if (empty($Contract)) {
            return HelperSkin::responseFormat(true, 'Danh sách trống');
        } 

       return response()->json([
                'success' => true,
                'message'   => 'Danh sách hợp đồng',
                'user'  =>$user,
                'salary'  =>$salary,
                'Contract' =>$Contract
            ],400);
    }

    /**
     * @OA\Get(
     *     path="/v2/listContractIsAboutToExpire",
     *     tags={"Contacts"},
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
    public function listContractIsAboutToExpire()
    {
        $user = User::all();
        $Contracts = Contract::with(['user'])->with(['salary'])->get();
        $listConTract = [];
        foreach($Contracts as $Contract)
        {
            if( Carbon::now()->diffInMonths(Carbon::parse($Contract->finish_date)) <= 6)
            {
                $listConTract[] = $Contract;
            }
        }
        $salary = Salary::all();
        return response()->json([
            'success' => true,
            'message'   => 'Danh sách hợp đồng gần hết hạn',
            'user'  =>$user,
            'salary'  =>$salary,
            'Contract' =>$listConTract
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
        $salary = Salary::all();
        $code = 'HD'.Contract::withTrashed()->max('id') + 1;
        $this->breadcrumb['page'] = 'Thêm mới';
        $data = [
            'users'         => $user,
            'salary'    =>$salary,
            'code'   => $code,
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
     *     path="/v2/Contact/create",
     *     tags={"Contacts"},
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
     * @OA\Parameter(
     *         name="signing_date",
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
     * @OA\Parameter(
     *         name="content",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ),
     *  @OA\Parameter(
     *         name="salary_id",
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
    public function createContact(Request $request)
    {
        $validator = Validator::make(
            $request->all(),
            [
                'start_date' => 'required',
                'finish_date' => 'required',
                'signing_date' => 'required',
                'user_id' =>  'required|unique:App\Models\Contract,user_id,NULL,id,deleted_at,NULL',
                'content' => 'required',
                // 'renewal_number' => 'required',
                'salary_id' => 'required',
            ],
            [
                'user_id.unique' =>'Nhân viên này đã có hợp đồng rồi bạn không thể tạo thêm',
                'start_date.required' => 'Bạn chưa chọn ngày bắt đầu',
                'finish_date.required' => 'Bạn chưa chọn ngày kết thúc',
                'signing_date.required' => 'Bạn chưa chọn ngày kí hợp đồng',
                'content.required' => 'Bạn chưa nhập nội dung',
                'salary_id.required' =>'Bạn chưa chọn loại lương',
                'content.required' =>'Bạn chưa nhập nội dung',
            ]
        );
        if ($validator->fails()) {
            return response()->json([
                'status' => 'warning',
                'message' => $validator->messages()->first(),
            ], 200);
        }
        $newContract = Contract::create([
            'code'          =>  $request->code,
            'start_date'    =>  $request->start_date,
            'finish_date'   =>  $request->finish_date,
            'signing_date'  =>  $request->signing_date,
            'user_id'       =>  $request->user_id,
            'content'       =>  $request->content,
            'salary_id'     =>  $request->salary_id,
        ]);
       if($newContract)
       {
        return HelperSkin::responseFormat(true, 'Thêm thành công',$newContract);
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
        $contract = Contract::find($id);
        $salary = Salary::all();
        $data = [
            'users'         => $user,
            'contract'  => $contract,
            'salary'    =>$salary,
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
     *     path="/v2/Contact/update",
     *     tags={"Contacts"},
     * @OA\Parameter(
     *         name="id",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="integer")
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
     * @OA\Parameter(
     *         name="signing_date",
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
     * @OA\Parameter(
     *         name="content",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ),
     *  @OA\Parameter(
     *         name="salary_id",
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
    public function updateContact(Request $request)
    {
        (  $request->all());
        $validator = Validator::make(
            $request->all(),
            [
                'start_date' => 'required',
                'finish_date' => 'required',
                'signing_date' => 'required',
                // 'user_id' =>  "required|unique:App\Models\Contract,user_id,{$request->id},id,deleted_at,NULL",
                'content' => 'required',
                // 'renewal_number' => 'required',
                'salary_id' => 'required',
            ],
            [
                'user_id.unique' =>'Nhân viên này đã có hợp đồng rồi bạn không thể tạo thêm',
                'start_date.required' => 'Bạn chưa chọn ngày bắt đầu',
                'finish_date.required' => 'Bạn chưa chọn ngày kết thúc',
                'signing_date.required' => 'Bạn chưa chọn ngày kí hợp đồng',
                'content.required' => 'Bạn chưa nhập nội dung',
                'salary_id.required' =>'Bạn chưa chọn loại lương',
                'content.required' =>'Bạn chưa nhập nội dung',
            ]
        );
        if ($validator->fails()) {
            return response()->json([
                'status' => 'warning',
                'message' => $validator->messages()->first(),
            ], 200);
        }
        $update = Contract::find($request->id);
        if(empty($update))
        {
            return HelperSkin::responseFormat(true, 'Không tìm thấy hợp đồng này');
        }
        $update->start_date = $request->start_date;
        $update-> finish_date = $request->finish_date;
        $update-> signing_date = $request->signing_date;
        $update-> user_id = $request->user_id;
        $update-> content = $request->content;
        $update-> salary_id = $request->salary_id;
        $update->save();
        
        if($update)
       {
        return HelperSkin::responseFormat(true, 'Update thành công',$update);
       }
       return HelperSkin::responseFormat(true, 'Update thất bại');

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
     /**
     * @OA\post(
     *     path="/v2/Contact/delete",
     *     tags={"Contacts"},
     *  @OA\Parameter(
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
    public function deleteContact(Request $request)
    {
        $delete = Contract::destroy($request->id);
        if(empty($delete))
        {
          return HelperSkin::responseFormat(true, 'Không tìm thấy hợp đồng này này');
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
    public function loadAjaxListContract(Request $request)
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
        $filter['name'] =  $searchValue;
        $filter = $this->customFilterAjax($filter, $columnName_arr);
        // Total records
        $totalRecords  = Contract::count();
        $totalRecordswithFilter = Contract::queryData($filter)->distinct()->count();
        $Contract = Contract::select(['Contracts.*'])
        ->with(['user'])
        ->with(['salary'])
        ->QueryData($filter)
        ->orderBy($columnName, $columnSortOrder)->distinct()->skip($start)->take($rowperpage)->get();

        $response = [
            "draw"                 => intval($draw),
            "iTotalRecords"        => $totalRecords,
            "iTotalDisplayRecords" => $totalRecordswithFilter,
            "aaData"               => $Contract,
            "filter"               => $filter,
        ];
        echo json_encode($response);
        exit;
    }
    public function loadAjaxContractIsAboutToExpire(Request $request)
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
        $filter['name'] =  $searchValue;
        $filter = $this->customFilterAjax($filter, $columnName_arr);
        // Total records
        $totalRecords  = Contract::count();
        $totalRecordswithFilter = Contract::queryData($filter)->distinct()->count();
        $Contracts = Contract::select(['Contracts.*'])
        ->with(['user'])
        ->with(['salary'])
        ->QueryData($filter)
        ->orderBy($columnName, $columnSortOrder)->distinct()->skip($start)->take($rowperpage)->get();

        $listConTract = [];
        foreach($Contracts as $Contract)
        {
            if( Carbon::now()->diffInMonths(Carbon::parse($Contract->finish_date)) <= 6)
            {
                $listConTract[] = $Contract;
            }
        }
        $response = [
            "draw"                 => intval($draw),
            "iTotalRecords"        => $totalRecords,
            "iTotalDisplayRecords" => $totalRecordswithFilter,
            "aaData"               => $listConTract,
            "filter"               => $filter,
        ];
        echo json_encode($response);
        exit;
    }
}

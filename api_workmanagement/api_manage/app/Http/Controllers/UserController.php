<?php

namespace App\Http\Controllers;

use App\Helpers\HelperSkin;
use App\Jobs\ForgotPasswordMail;
use App\Models\User;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use App\Models\Role;
use App\Models\Department;

class UserController extends Controller
{
    // public function __construct() {
    //     $this->middleware('auth:api');
    // }
    /**
     * @OA\Post(
     *     path="/v2/login",
     *     tags={"Accounts"},
     *     @OA\Parameter(
     *         name="username",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ),
     *      @OA\Parameter(
     *         name="password",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
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
     *      )
     * )
     */
    public function login(Request $request)
    {
        $username = $request->username;
        $password = $request->password;

        //check if field is empty
        if (empty($username) || empty($password)) {
          
            return response()->json([
                'status' => 'error',
                'message' => "Username hoặc mật khẩu không được để trống",
            ], 400);
        }
        $check_acc = User::where('username', 'like', $username)->first();
        if (empty($check_acc)) {
            return response()->json([
                'status' => 'error',
                'message' => "Email hoặc mật khẩu không chính xác",
            ], 401);
        }

        if ($token = auth()->attempt(['username' => $username, 'password' => $password])) {
          
            return $this->respondWithToken($token, Auth::user());
        }

        return response()->json(['status' => 'error', 'message' => 'Email hoặc mật khẩu không đúng'], 401);
    }

    /**
     * @OA\Post(
     *     path="/v2/forgot-password",
     *     tags={"Accounts"},
     *    @OA\Parameter(
     *         name="email",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ),
     *    @OA\Parameter(
     *         name="language",
     *         in="header",
     *         description="vn/en",
     *         required=false,
     *         @OA\Schema(type="string")
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
     *      )
     * )
     */
    public function forgotPassword(Request $request)
    {

        if (empty($request->header('language'))) {
            $check_language = 'vn';
        } else {

            $check_language = $request->header('language');
        }

        if($check_language == 'vn'){
            $message = [
                'email.required' => 'Vui lòng nhập email.',
                'email.regex' => 'Email không đúng định dạng.'
            ];
        }else{
            $message = [
                'email.required' => 'The email field is required.',
                'email.regex' => 'The email format is invalid.'
            ];
        }
        
        $validator = Validator::make($request->all(), [
            'email' => 'required|regex:/(.+)@(.+)\.(.+)/i'
        ], $message);

        if ($validator->fails()) {
            return response()->json([
                'status' => 'error',
                'code'   => 422,
                'message' => $validator->errors()->first(),
            ], 422);
        }

        $email = $request->email;

        $user = User::where('email', 'like', $request->email)->first();
        if (empty($user)) {
            // Lang::get('messages.error');
            if ($check_language == 'en') {
                return response()->json([
                    'status' => 'error',
                    'message' => "Email is not registered",
                ]);
            }
            return response()->json([
                'status' => 'error',
                'message' => "Email chưa được đăng ký",
            ]);
        }

        $otp = rand(100000, 999999);

        $now = Carbon::now();
        $expired_time = $now->add(1, 'hour'); //thời gian hết hạn của otp

        User::where('id', $user->id)->update(['otp' => $otp, 'expired_time' => $expired_time->toDateTimeString()]);

        $job = (new ForgotPasswordMail($email, $otp));

        $this->dispatch($job);

        // return response()->json('send success');
        if ($check_language == 'vn') {
            return response()->json([
                'status' => 'success',
                'message' => "Mã OTP đã được gửi tới email",
            ]);
        }
        return response()->json([
            'status' => 'success',
            'message' => "OTP has been sent to email",
        ], 200);
    }


    /**
     * Get the token array structure.
     *
     * @param  string $token
     *
     * @return \Illuminate\Http\JsonResponse
     */
    protected function respondWithToken($token, $user)
    {
        return response()->json([
            'access_token' => $token,
            'token_type' => 'bearer',
            'message'=>'đăng nhập thành công',
            'status'=>'success',
            'redirect'=>'http://127.0.0.1:8000/',
            'expires_in' => (int)auth()->factory()->getTTL(),
            'user' => $user
        ]);
    }

    /**
     * @OA\Post(
     *     path="/v2/logout",
     *     tags={"Accounts"},
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
    public function logout()
    {
        auth()->logout();
        return response()->json(['status' => 'success', 'message' => 'Successfully logged out'], 200);
    }


    public function __construct()
    {
        $this->module = 'user';
        $this->breadcrumb = [
            'object'    => 'Nhân viên',
            'page'      => ''
        ];
        $this->title = 'Người dùng';
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
 /**
     * @OA\Get(
     *     path="/v2/listUser",
     *     tags={"Accounts"},
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
    public function listUser()
    {
        $user = User::all();
        $role = Role::all();
        $department = Department::all();
        $data['role'] = $role;
        $data['department'] = $department;
        $data['user'] = $user;


        if (empty($user)) {
           
            return HelperSkin::responseFormat(true, 'Danh sách trống');
        } 
            return response()->json([
                'success' => true,
                'message'   => 'Danh sách User',
                'user'  =>$user,
                'department'  =>$department,
                'role'  =>$role,

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
     *     path="/v2/user/create",
     *     tags={"Accounts"},
     * @OA\Parameter(
     *         name="fullname",
     *         in="query",
     *         required=false,
     *         @OA\Schema(type="string")
     *     ),
     *  @OA\Parameter(
     *         name="username",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ), 
    *          @OA\Parameter(
     *         name="password",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ), 
     * @OA\Parameter(
     *         name="birthday",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ), 
     * @OA\Parameter(
     *         name="phone",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ),
     * @OA\Parameter(
     *         name="address",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ),
     * @OA\Parameter(
     *         name="citizen_identification",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ),
     * @OA\Parameter(
     *         name="email",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ),
     *  @OA\Parameter(
     *         name="role_id",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ),
     * @OA\Parameter(
     *         name="department_id",
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
    public function createUser(Request $request)
    {
        $validator = Validator::make(
            $request->all(),
            [
                'fullname' => 'required',
                'username' => 'required|unique:App\Models\User,username,NULL,id,deleted_at,NULL',
                'password' => 'required',
                'birthday' => 'required',
                'phone' => 'required|unique:App\Models\User,phone,NULL,id,deleted_at,NULL',
                'address' => 'required',
                'citizen_identification' => 'required|unique:App\Models\User,citizen_identification,NULL,id,deleted_at,NULL',
                'email' => 'required|unique:App\Models\User,email,NULL,id,deleted_at,NULL',
                'role_id' => 'required',
                'department_id' => 'required',
            ],
            [
                'fullname.required' => 'Họ tên không được trống',
                'username.required' => 'Tên đăng nhập không được trống',
                'username.unique' => 'Tên đăng nhập đã tồn tại',
                'password.required' => 'Mật khẩu không được trống',
                'birthday.required' => 'Ngày sinh không được trống',
                'phone.unique' => 'Số điện thoại đã tồn tại',
                'phone.required' => 'Số điện thoại không được trống',
                'address.required' => 'Địa chỉ không được trống',
                'citizen_identification.required' => 'CMND/CCCD không được trống',
                'citizen_identification.unique' => 'CMND/CCCD đã tồn tại',
                'email.required' => 'Email không được trống',
                'email.unique' => 'Email đã tồn tại',
                'role_id.required' => 'Chưa chọn chức vụ',
            ]
        );
        if ($validator->fails()) {
            return response()->json([
                'status' => 'Lỗi rồi kìa',
                'message' => $validator->messages()->first(),
            ], 200);
        }
       $user = User::create(
            [
                'fullname'                  => $request->fullname,
                'username'                  => $request->username,
                'password'                  => Hash::make($request->password),
                'birthday'                  => $request->birthday,
                'phone'                     => preg_replace('/\s+/', '', $request->phone),
                'address'                   => $request->address,
                'citizen_identification'    => $request->citizen_identification,
                'email'                     => $request->email,
                'role_id'                   => $request->role_id,
                'department_id'             => $request->role_id
            ]
        );
        if ($user) {
            $role = Role::find($request->role_id);
            $user->assignRole($role->name);
            return HelperSkin::responseFormat(true, 'Tạo tài khoản thành công', $user);
        } 
        return HelperSkin::responseFormat(true, 'Tạo tài khoản thất bại');

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
        $role = Role::all();
        $this->breadcrumb['page'] = 'Cập nhật';
        $user = User::find($id);
        $department = Department::all();
        $data = [
            'user'      => $user,
            'roles' => $role,
            'departments'   => $department,
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
     *     path="/v2/user/update",
     *     tags={"Accounts"},
     *    @OA\Parameter(
     *         name="id",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="integer")
     *     ),
     * @OA\Parameter(
     *         name="fullname",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ),
     *  @OA\Parameter(
     *         name="username",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ), 
    *          @OA\Parameter(
     *         name="password",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ), 
     * @OA\Parameter(
     *         name="birthday",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ), 
     * @OA\Parameter(
     *         name="phone",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ),
     * @OA\Parameter(
     *         name="address",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ),
     * @OA\Parameter(
     *         name="citizen_identification",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ),
     * @OA\Parameter(
     *         name="email",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ),
     *  @OA\Parameter(
     *         name="role_id",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ),
     * @OA\Parameter(
     *         name="department_id",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string")
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
    public function updateUser(Request $request)
    {
        $validator = Validator::make(
            $request->all(),
            [
                'fullname' => 'required',
                'username' => "required|unique:App\Models\User,username,{$request->id},id,deleted_at,NULL",
                'email' => "required|unique:App\Models\User,email,{$request->id},id,deleted_at,NULL",
                'phone' => "required|unique:App\Models\User,phone,{$request->id},id,deleted_at,NULL",
                'citizen_identification' => "required|unique:App\Models\User,citizen_identification,{$request->id},id,deleted_at,NULL",
                'address' => 'required',
                'role_id' => 'required',
                'department_id' => 'required',
            ],
            [
                'fullname.required' => 'Họ tên không được trống',
                'username.required' => 'Tên đăng nhập không được trống',
                'username.unique' => 'Tên đăng nhập đã tồn tại',
                'email.required' => 'Email không được trống',
                'email.unique' => 'Email đã tồn tại',
                'phone.unique' => 'Số điện thoại đã tồn tại',
                'phone.required' => 'Số điện thoại không được trống',
                'citizen_identification.unique' => 'CMND/CCCD đã tồn tại',
                'citizen_identification.required' => 'CMND/CCCD không được trống',
                'address.required' => 'Địa chỉ không được trống',
                'role_id.required' => 'Chưa chọn chức vụ',
                'department_id.required' => 'Chưa chọn phòng ban',
            ]
        );
        if ($validator->fails()) {
            return response()->json([
                'status' => 'warning',
                'message' => $validator->messages()->first(),
            ], 200);
        }
        $user = User::find($request->id);
        if (!empty($user)) {
            $user->fullname = $request->fullname;
            $user->username = $request->username;
            $user->birthday = $request->birthday;
            $user->citizen_identification = $request->citizen_identification;
            $user->email = $request->email;
            $user->phone = preg_replace('/\s+/', '', $request->phone);
            $user->address = $request->address;
            $user->role_id = $request->role_id;
            $user->department_id = $request->department_id;
            $user->save();
        }
        else{
            return HelperSkin::responseFormat(true, 'Không tìm thấy tài khoản này');
        }
        $listRole = explode(",", $request->role_id);
        $delete_roles = Role::whereNotIn('id',$listRole)->get();
        foreach($delete_roles as $delete_role)
        {
            $user->removeRole($delete_role->name);
        }

        foreach($listRole as $id)
        {
            $role = Role::find($id);
            $user->assignRole($role->name);
        }
        if ($user) {
            return HelperSkin::responseFormat(true, 'Update tài khoản thành công', $user);
        } 
        return HelperSkin::responseFormat(true, 'Update tài khoản thất bại', $user);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    /**
     * @OA\post(
     *     path="/v2/user/delete",
     *     tags={"Accounts"},
     *    @OA\Parameter(
     *         name="id",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="integer")
     *     ),
     * 
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
    public function deleteUser(Request $request)
    {
        try {
            $user = User::destroy($request->id);
            if(empty($user))
            {
                return HelperSkin::responseFormat(true, 'Không tìm thấy tài khoản này');
            }
            if ($user) {
                return HelperSkin::responseFormat(true, 'Xoá tài khoản thành công');
            } 
            return HelperSkin::responseFormat(true, 'Xoá tài khoản thất bại',);
        } catch (Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Không tìm thấy yêu cầu',
            ], 200);
        }
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

    public function loadAjaxListUser(Request $request)
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
        $totalRecords  = User::count();
        $totalRecordswithFilter = User::queryData($filter)->distinct()->count();
        $user = User::select(['users.*'])
            ->leftjoin('roles', 'roles.id', '=', 'users.role_id')
            ->with(['role'])
            ->queryData($filter)
            ->orderBy($columnName, $columnSortOrder)->distinct()->skip($start)->take($rowperpage)->get();

        $response = [
            "draw"                 => intval($draw),
            "iTotalRecords"        => $totalRecords,
            "iTotalDisplayRecords" => $totalRecordswithFilter,
            "aaData"               => $user,
            "filter"               => $filter,
        ];
        echo json_encode($response);
        exit;
    }

  
}
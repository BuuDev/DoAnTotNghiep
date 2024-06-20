import 'dart:io';
import 'package:doantotnghiep/Models/ChangePassword/response_change_password.dart';
import 'package:doantotnghiep/Models/CheckIn/check_in.dart';
import 'package:doantotnghiep/Models/ResponseLogin/response.dart';
import 'package:doantotnghiep/Models/UserSkinDetective/response_get_list_user.dart';
import 'package:doantotnghiep/Models/UserSkinDetective/response_search_user.dart';
import 'package:doantotnghiep/Models/demoModels/demo_model.dart';
import 'package:doantotnghiep/Services/Api/api_client.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'demo.g.dart';

@RestApi()
abstract class DemoService {
  factory DemoService(Dio dio, {String baseUrl}) = _DemoService;

  factory DemoService.client({bool? isLoading}) {
    return DemoService(
        ClientApi().initDio()..options.headers['isLoading'] = isLoading);
  }

  @GET("/posts")
  Future<List<DemoModels>> getUsers();

  @POST("/login")
  Future<ResponseUser> login(
      @Query('username') String username, @Query('password') String password);

  @GET('/listUser')
  Future<ResponseListUser> getListUser(
      {@Query('paginate') int? paginate,
      @Query('page') int? page,
      @Query('department_id') int? departmentId});

  @POST('/user/create')
  Future<ResponseChangePassword> addNewEmployee(
      @Query('fullname') String fullname,
      @Query('username') String username,
      @Query('password') String password,
      @Query('birthday') String birthday,
      @Query('phone') String phone,
      @Query('address') String address,
      @Query('citizen_identification') String cmnd,
      @Query('email') String email,
      @Query('role_id') int roleId,
      @Query('department_id') int departmentId,
      [@Part(name: "avatar[]") File? avatar]);

  @POST('/user/update')
  Future<ResponseChangePassword> updateEmployee(
      @Query('id') int id,
      @Query('fullname') String fullname,
      @Query('username') String username,
      @Query('birthday') String birthday,
      @Query('phone') String phone,
      @Query('address') String address,
      @Query('citizen_identification') String cmnd,
      @Query('email') String email,
      @Query('role_id') int roleId,
      @Query('department_id') int departmentId,
      [@Part(name: "avatar[]") File? avatar]);

  @GET('/checkIn')
  Future<CheckInResponse> kiemTraCheckIn();

  @POST('/authCheckin')
  Future<void> checkIn();

  @GET('/checkoutAt')
  Future<CheckInResponse> kiemTraCheckout();

  @GET('/checkOut')
  Future<void> checkOut();

  @POST('/account/change-Password')
  Future<ResponseChangePassword> changePassword(
      @Query('old_password') String oldPassword,
      @Query('new_password') String newPassword,
      @Query('confirm_password') String confirmPassword);

  @GET('/token/refresh')
  Future<ResponseUser> reFreshToken();

  @POST('/user/changeUser')
  Future<ResponseChangePassword> updateInfoUser(
      @Query('fullname') String fullname,
      @Query('username') String username,
      @Query('birthday') String birthday,
      @Query('phone') String phone,
      @Query('address') String address,
      @Query('citizen_identification') String cmnd,
      @Query('email') String email,
      @Query('role_id') int roleId,
      @Query('department_id') int departmentId,
      [@Part(name: "avatar[]") File? avatar]);

  @GET('/searchUser')
  Future<ResponseSearchUser> searchUser({
    @Query('paginate') int? paginate,
    @Query('page') int? page,
    @Query('fullname') String? fullname,
  });
}

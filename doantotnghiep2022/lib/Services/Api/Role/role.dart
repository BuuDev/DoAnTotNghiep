import 'package:doantotnghiep/Models/ChangePassword/response_change_password.dart';
import 'package:doantotnghiep/Models/Role/list_role_data.dart';
import 'package:doantotnghiep/Services/Api/api_client.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'role.g.dart';

@RestApi()
abstract class RoleService {
  factory RoleService(Dio dio, {String baseUrl}) = _RoleService;

  factory RoleService.client({bool? isLoading}) {
    return RoleService(
        ClientApi().initDio()..options.headers['isLoading'] = isLoading);
  }

  @GET("/listRole")
  Future<ListRoleData> getListRole();

  @POST('/Role/create')
  Future<ResponseChangePassword> createNewRole(
      @Query('name') String name, @Query('permission_id ') String permissionId);

  @POST('/Role/update')
  Future<ResponseChangePassword> updateRole(
      @Query('id') int id, @Query('permission_id') String permissionId);

  @POST('/Role/delete')
  Future<ResponseChangePassword> deleteRole(@Query('id') int id);
}

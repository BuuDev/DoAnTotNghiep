import 'package:doantotnghiep/Models/ChangePassword/response_change_password.dart';
import 'package:doantotnghiep/Models/Department/list_department.dart';
import 'package:doantotnghiep/Services/Api/api_client.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'department.g.dart';

@RestApi()
abstract class DepartmentService {
  factory DepartmentService(Dio dio, {String baseUrl}) = _DepartmentService;

  factory DepartmentService.client({bool? isLoading}) {
    return DepartmentService(
        ClientApi().initDio()..options.headers['isLoading'] = isLoading);
  }

  @GET("/listDepartment")
  Future<ListDepartment> getListDepartment();

  @POST('/department/create')
  Future<ResponseChangePassword> addNewDepartment(@Query('name') String name);

  @POST('/department/update')
  Future<ResponseChangePassword> updateDepartment(
      @Query('id') int id, @Query('name') String name);

  @POST('/department/delete')
  Future<ResponseChangePassword> deleteDepartment(@Query('id') int id);
}

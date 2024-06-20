import 'package:doantotnghiep/Models/workManage/work/assign/assign.dart';
import 'package:doantotnghiep/Models/workManage/work/garbage/garbage.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../Models/workManage/level/level_response.dart';
import '../../../../Models/workManage/task/task_response.dart';
import '../../../../Models/workManage/work/work_response.dart';
import '../../api_client.dart';

part 'work.g.dart';

@RestApi()
abstract class WorkService {
  factory WorkService(Dio dio, {String baseUrl}) = _WorkService;

  factory WorkService.client({bool? isLoading = false}) {
    return WorkService(
        ClientApi().initDio()..options.headers['isLoading'] = isLoading);
  }

  @GET("/project/list")
  Future<WorkResponse> getWorkUser();

  @POST("/project/create")
  Future<ResponseAssign> createWork(
    @Query('name') String name,
    @Query('priority ') String priority,
    @Query('starting ') String starting,
    @Query('ending ') String ending,
    @Query('size ') String size,
    @Query('detail ') String detail,
  );

  @POST("/project/edit/{id}")
  Future<ResponseAssign> editWork(
    @Path('id') int id,
    @Query('name') String? name,
    @Query('priority ') String? priority,
    @Query('starting ') String? starting,
    @Query('ending ') String? ending,
    @Query('size ') String? size,
    @Query('detail ') String? detail,
  );

  @POST("/project/delete/{id}")
  Future<ResponseAssign> deleteWork(
    @Path('id') int id,
  );

  @POST("/project/{id}/assign")
  Future<ResponseAssign> assignUserWork(
      @Path('id') int id, @Query('user_id') int user_id);

  @GET("/project/{id}/task/trash")
  Future<GarbageModelResponse> garbageWork(@Path('id') int id);

  @POST("/project/assign/{id}/delete")
  Future<ResponseAssign> deleteAssignUserWork(
    @Path('id') int id_user_work,
  );

  @GET("/project/{id}/level")
  Future<LevelResponse> getLevelWork(
    @Path('id') int id,
  );

  @POST("/project/{id_work}/level/create")
  Future<ResponseAssign> createLevel(
    @Path('id_work') int id_work,
    @Query("name") String name,
  );

  @POST("/project/level/edit/{id_level}")
  Future<ResponseAssign> editLevel(
    @Path('id_level') int id_level,
    @Query("name") String name,
  );

  @POST("/project/level/delete/{id_level}")
  Future<ResponseAssign> deleteLevel(
    @Path('id_level') int id_level,
  );

  @GET("/task/list")
  Future<TaskResponse> getTaskLevel(@Query('work_id') int work_id);
}

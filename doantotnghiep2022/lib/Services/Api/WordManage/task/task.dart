import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../Models/workManage/work/assign/assign.dart';
import '../../api_client.dart';

part 'task.g.dart';

@RestApi()
abstract class TaskService {
  factory TaskService(Dio dio, {String baseUrl}) = _TaskService;

  factory TaskService.client({bool? isLoading = false}) {
    return TaskService(
        ClientApi().initDio()..options.headers['isLoading'] = isLoading);
  }

  @POST("/task/create")
  Future<ResponseAssign> createTask(
    @Query('id_level') int id_level,
    @Query("title") String title,
    @Query("content") String? content,
    @Query("timeStart") String? timeStart,
    @Query("ending") String? ending,
  );

  @POST("/task/{id}/edit")
  Future<ResponseAssign> editTask(
    @Path('id') int id_task,
    @Query("title") String title,
    @Query("content") String content,
    @Query("timeStart") String timeStart,
    @Query("ending") String ending,
  );

  @POST("/task/{id}/delete")
  Future<ResponseAssign> deleteTask(
    @Path('id') int id,
  );

  @POST("/task/{id}/assign")
  Future<ResponseAssign> assignUserTask(
    @Path('id') int id_task,
    @Query('user_id') int user_id,
  );

  @POST("/task/{id}/comment/create")
  Future<ResponseAssign> createComment(
    @Path('id') int id_task,
    @Query('content') String content,
  );

  @POST("/assign/{id}/delete")
  Future<ResponseAssign> deleteAssignUserTask(
      @Path('id') int id_user_work,);
}

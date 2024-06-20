import 'package:doantotnghiep/Models/Task_Timekeep/task_timekeep.dart';
import 'package:doantotnghiep/Models/Timekeep/time_keep.dart';
import 'package:doantotnghiep/Models/duyet_cham_cong/duyet_cham_cong.dart';
import 'package:doantotnghiep/Services/Api/api_client.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'timekeep_api.g.dart';

@RestApi()
abstract class TimeKeepService {
  factory TimeKeepService(Dio dio, {String baseUrl}) = _TimeKeepService;

  factory TimeKeepService.client({bool? isLoading = false}) {
    return TimeKeepService(
        ClientApi().initDio()..options.headers['isLoading'] = isLoading);
  }

  @GET("/listTimesheet")
  Future<TimeKeepResponse> getTimekeep({
    @Query('month') String? month,
    @Query('user_id') String? id,
  });
  @POST("/user/{id}/task/complete")
  Future<TaskTimeKeep> getTask(
    @Path('id') int id,
    @Query('date') String date,
  );

  @POST("/checkTimesheet")
  Future<ApproveTimeKeep> chamCong(
    @Query('id') String id,
  );
}

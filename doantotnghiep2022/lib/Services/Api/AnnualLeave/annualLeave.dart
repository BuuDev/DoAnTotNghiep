import 'package:doantotnghiep/Models/ChangePassword/response_change_password.dart';
import 'package:doantotnghiep/Models/approve/approve.dart';
import 'package:doantotnghiep/Models/don_xin_nghi_phep/don_xin_nghi_reponse.dart';
import 'package:doantotnghiep/Services/Api/api_client.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'annualLeave.g.dart';

@RestApi()
abstract class Leave {
  factory Leave(Dio dio, {String baseUrl}) = _Leave;

  factory Leave.client({bool? isLoading = false}) {
    return Leave(
        ClientApi().initDio()..options.headers['isLoading'] = isLoading);
  }

  @GET("/waitingListForApproval")
  Future<AnnualLeave> getAnnualLeave();

  @GET("/AnnualLeave/listDisApprove")
  Future<AnnualLeave> getListDisApprove();

  @GET("/listAnnualLeave")
  Future<AnnualLeave> getApproved({@Query('user_id') int? id});

  @POST("/AnnualLeave/approve")
  Future<Approve> approved(@Query('id') String id);

  @POST("/AnnualLeave/disApprove")
  Future<Approve> disapproved(@Query('id') String id,
      @Query('reason_not_approving') String reason_not_approving);

  @POST('/AnnualLeave/create')
  Future<ResponseChangePassword> createAnnualLeave(
    @Query('start_date') String startDay,
    @Query('finish_date') String finishDate,
    @Query('user_id') String userId,
    @Query('reason') String reason,
  );

  @POST('/AnnualLeave/update')
  Future<ResponseChangePassword> updateAnnualLeave(
    @Query('id') int id,
    @Query('start_date') String startDay,
    @Query('finish_date') String finishDate,
    @Query('user_id') String userId,
    @Query('reason') String reason,
  );

  @GET('/listAnnualLeaveInUser')
  Future<AnnualLeave> getAnnualListUser();

  @POST('/AnnualLeave/delete')
  Future<ResponseChangePassword> deleteDonNghiPhep(@Query('id') int id);
}

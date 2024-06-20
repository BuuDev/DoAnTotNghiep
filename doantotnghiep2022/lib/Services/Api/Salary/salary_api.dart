import 'package:doantotnghiep/Models/salary/salary_response.dart';
import 'package:doantotnghiep/Services/Api/api_client.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'salary_api.g.dart';

@RestApi()
abstract class SalaryService {
  factory SalaryService(Dio dio, {String baseUrl}) = _SalaryService;

  factory SalaryService.client({bool? isLoading = false}) {
    return SalaryService(
        ClientApi().initDio()..options.headers['isLoading'] = isLoading);
  }

  @GET("/paySalarie/list")
  Future<SalaryResponse> getSalary(@Query('month') String month);

  @GET('/paySalarie/listAuthUser')
  Future<SalaryResponse> getSalaryListUser(@Query('month') String month);
}

import 'package:doantotnghiep/Models/Province/province.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'province.g.dart';

@RestApi()
abstract class ProvinceService {
  factory ProvinceService(Dio dio, {String baseUrl}) = _ProvinceService;

  // factory ProvinceService.client({bool? isLoading}) {
  //   return ProvinceService(ClientApi().initDio());
  // }

  @GET("/province")
  Future<List<Province>> getProvince();
}

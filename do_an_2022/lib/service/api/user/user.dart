import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../Models/user_info/user_info.dart';
import '../api_client.dart';

part 'user.g.dart';

@RestApi()
abstract class UserService {
  factory UserService(Dio dio, {String baseUrl}) = _UserService;

  factory UserService.client({bool? isLoading}) {
    return UserService(
        ClientApi().init()..options.headers['isLoading'] = isLoading);
  }

  @POST("/login")
  Future<UserInfo> getLogin(@Field("email") email, @Field("password") password);
}

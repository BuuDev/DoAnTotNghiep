import 'package:doantotnghiep/Models/UserSkinDetective/user_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'response_search_user.g.dart';

@JsonSerializable()
class ResponseSearchUser {
  UserResponse user;

  ResponseSearchUser({required this.user});

  factory ResponseSearchUser.fromJson(Map<String, dynamic> json) =>
      _$ResponseSearchUserFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseSearchUserToJson(this);
}

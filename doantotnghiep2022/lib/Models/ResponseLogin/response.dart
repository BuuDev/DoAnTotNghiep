import 'package:doantotnghiep/Models/UserSkinDetective/user_demo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'response.g.dart';

@JsonSerializable()
class ResponseUser {
  String access_token;
  UserDemo user;

  ResponseUser({required this.access_token, required this.user});

  factory ResponseUser.fromJson(Map<String, dynamic> json) =>
      _$ResponseUserFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseUserToJson(this);
}

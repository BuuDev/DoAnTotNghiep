import 'package:doantotnghiep/Models/UserSkinDetective/user_demo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  List<UserDemo>? data;
  int currentPage;
  int perPage;
  int total;

  UserResponse(
      {required this.data,
      required this.currentPage,
      required this.perPage,
      required this.total});

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

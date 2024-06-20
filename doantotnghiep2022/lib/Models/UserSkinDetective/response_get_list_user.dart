import 'package:doantotnghiep/Models/Department/department.dart';
import 'package:doantotnghiep/Models/UserSkinDetective/role_user.dart';
import 'package:doantotnghiep/Models/UserSkinDetective/user_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'response_get_list_user.g.dart';

@JsonSerializable()
class ResponseListUser {
  UserResponse user;
  List<RoleUser> role;
  List<Department> department;
  ResponseListUser(
      {required this.user, required this.department, required this.role});

  factory ResponseListUser.fromJson(Map<String, dynamic> json) =>
      _$ResponseListUserFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseListUserToJson(this);
}

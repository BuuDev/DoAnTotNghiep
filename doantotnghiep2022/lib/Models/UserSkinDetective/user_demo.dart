import 'package:doantotnghiep/Models/Department/department.dart';
import 'package:doantotnghiep/Models/UserSkinDetective/role_user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_demo.g.dart';

@JsonSerializable()
class UserDemo {
  int? id;
  String? code;
  String? fullname;
  String? username;
  String? birthday;
  @JsonKey(name: 'citizen_identification')
  String? citizenIdentification;
  String? avatar;
  String? email;
  String? phone;
  String? address;
  @JsonKey(name: 'role_id')
  int? roleId;
  @JsonKey(name: 'department_id')
  int? departmentId;
  RoleUser? role;
  Department? department;

  UserDemo({
    required this.email,
    required this.avatar,
    required this.id,
    required this.fullname,
    required this.address,
    required this.birthday,
    required this.citizenIdentification,
    required this.code,
    required this.departmentId,
    required this.phone,
    required this.roleId,
    required this.username,
    this.role,
    this.department,
  });

  @override
  String toString() {
    return toJson().toString();
  }

  factory UserDemo.fromJson(Map<String, dynamic> json) =>
      _$UserDemoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDemoToJson(this);
}

import 'package:doantotnghiep/Models/Role/permission.dart';
import 'package:doantotnghiep/Models/Role/role.dart';
import 'package:json_annotation/json_annotation.dart';
part 'list_role_data.g.dart';

@JsonSerializable()
class ListRoleData {
  List<Role> role;
  List<Permisstion> permission;
  ListRoleData({required this.role, required this.permission});

  factory ListRoleData.fromJson(Map<String, dynamic> json) =>
      _$ListRoleDataFromJson(json);

  Map<String, dynamic> toJson() => _$ListRoleDataToJson(this);
}

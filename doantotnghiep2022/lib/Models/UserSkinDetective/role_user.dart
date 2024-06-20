import 'package:json_annotation/json_annotation.dart';
part 'role_user.g.dart';

@JsonSerializable()
class RoleUser {
  int id;
  String name;

  RoleUser({required this.id, required this.name});

  factory RoleUser.fromJson(Map<String, dynamic> json) =>
      _$RoleUserFromJson(json);

  Map<String, dynamic> toJson() => _$RoleUserToJson(this);
}

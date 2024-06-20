import 'package:json_annotation/json_annotation.dart';
part 'role_models.g.dart';

@JsonSerializable()
class Roles {
  final int id;
  final String title;
  final List<String> listRoles;

  Roles({required this.id, required this.title, required this.listRoles});

  factory Roles.fromJson(Map<String, dynamic> json) => _$RolesFromJson(json);

  Map<String, dynamic> toJson() => _$RolesToJson(this);
}

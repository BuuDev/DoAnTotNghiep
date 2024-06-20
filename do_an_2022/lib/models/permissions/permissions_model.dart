import 'package:json_annotation/json_annotation.dart';
part 'permissions_model.g.dart';

@JsonSerializable()
class Permissions {
  int id;
  String name;
  @JsonKey(name: 'guard_name')
  String guardName;
  @JsonKey(name: "created_at")
  String? createdat;
  @JsonKey(name: "updated_at")
  String updatedat;
  @JsonKey(name: "deleted_at")
  String deletedat;

  Permissions(
      {required this.id,
      required this.name,
      required this.guardName,
      required this.createdat,
      required this.updatedat,
      required this.deletedat});

  factory Permissions.fromJson(Map<String, dynamic> json) =>
      _$PermissionsFromJson(json);

  Map<String, dynamic> toJson() => _$PermissionsToJson(this);
}

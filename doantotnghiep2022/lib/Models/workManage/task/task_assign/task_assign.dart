import 'package:json_annotation/json_annotation.dart';
part 'task_assign.g.dart';

@JsonSerializable()
class TaskAssign {
  int id;
  int? user_id;
  String? tast_id;
  int? status;

  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'deleted_at')
  String? deletedAt;

  TaskAssign(
      {required this.id,
      required this.user_id,
      required this.status,
      required this.tast_id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt});

  @override
  String toString() {
    return toJson().toString();
  }

  factory TaskAssign.fromJson(Map<String, dynamic> json) =>
      _$TaskAssignFromJson(json);

  Map<String, dynamic> toJson() => _$TaskAssignToJson(this);
}

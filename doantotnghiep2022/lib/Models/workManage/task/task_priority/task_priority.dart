import 'package:json_annotation/json_annotation.dart';
part 'task_priority.g.dart';

@JsonSerializable()
class TaskPriority {
  int id;
  String name;
  String code;
  int status;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'deleted_at')
  String? deletedAt;

  TaskPriority(
      {required this.id,
      required this.code,
      required this.name,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt});

  @override
  String toString() {
    return toJson().toString();
  }

  factory TaskPriority.fromJson(Map<String, dynamic> json) =>
      _$TaskPriorityFromJson(json);

  Map<String, dynamic> toJson() => _$TaskPriorityToJson(this);
}

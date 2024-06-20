import 'package:json_annotation/json_annotation.dart';
part 'task_sub.g.dart';

@JsonSerializable()
class TaskSub {
  int id;
  String name;
  int status;

  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'deleted_at')
  String? deletedAt;

  TaskSub(
      {required this.id,
      required this.name,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt});

  @override
  String toString() {
    return toJson().toString();
  }

  factory TaskSub.fromJson(Map<String, dynamic> json) =>
      _$TaskSubFromJson(json);

  Map<String, dynamic> toJson() => _$TaskSubToJson(this);
}

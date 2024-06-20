import 'package:json_annotation/json_annotation.dart';
part 'task_attchaments.g.dart';

@JsonSerializable()
class TaskAttchaments {
  int id;
  int task_id;
  int user_id;
  String url;
  String type;
  String name;
  int status;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'deleted_at')
  String? deletedAt;

  TaskAttchaments(
      {required this.id,
      required this.task_id,
      required this.user_id,
      required this.url,
      required this.type,
      required this.name,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt});

  @override
  String toString() {
    return toJson().toString();
  }

  factory TaskAttchaments.fromJson(Map<String, dynamic> json) =>
      _$TaskAttchamentsFromJson(json);

  Map<String, dynamic> toJson() => _$TaskAttchamentsToJson(this);
}

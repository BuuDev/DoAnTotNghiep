import 'package:json_annotation/json_annotation.dart';
part 'task_details.g.dart';

@JsonSerializable()
class TaskDetails {
  int id;
  String description;
  int assignee;
  int reporter;
  String lable;
  @JsonKey(name: 'priority_id')
  int priorityId;
  int status;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'deleted_at')
  String? deletedAt;

  TaskDetails(
      {required this.id,
      required this.description,
      required this.assignee,
      required this.reporter,
      required this.lable,
      required this.priorityId,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt});

  @override
  String toString() {
    return toJson().toString();
  }

  factory TaskDetails.fromJson(Map<String, dynamic> json) =>
      _$TaskDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$TaskDetailsToJson(this);
}

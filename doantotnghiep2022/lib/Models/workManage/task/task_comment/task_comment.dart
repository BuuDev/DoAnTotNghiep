import 'package:json_annotation/json_annotation.dart';
part 'task_comment.g.dart';

@JsonSerializable()
class TaskComment {
  int id;
  int user_id;
  int task_id;
  String content;
  int status;

  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'deleted_at')
  String? deletedAt;

  TaskComment(
      {required this.id,
      required this.user_id,
      required this.task_id,
      required this.content,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt});

  @override
  String toString() {
    return toJson().toString();
  }

  factory TaskComment.fromJson(Map<String, dynamic> json) =>
      _$TaskCommentFromJson(json);

  Map<String, dynamic> toJson() => _$TaskCommentToJson(this);
}

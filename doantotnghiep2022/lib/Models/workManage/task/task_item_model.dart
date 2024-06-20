import 'package:doantotnghiep/Models/workManage/task/task_assign/task_assign.dart';
import 'package:json_annotation/json_annotation.dart';

import 'task_attachments/task_attchaments.dart';
import 'task_comment/task_comment.dart';
import 'task_priority/task_priority.dart';
part 'task_item_model.g.dart';

@JsonSerializable()
class TaskItemModel {
  int id;
  int level_id;
  int user_id;
  String? title;
  String? content;
  int? index;
  String? type;
  String? timeOut;
  String? timeStart;
  int? priority_id;
  int? status;
  @JsonKey(name: 'complete_at')
  String? completeAt;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'deleted_at')
  String? deletedAt;
  List<TaskAssign>? assign;
  TaskPriority? priority;
  List<TaskAttchaments>? attchaments;
  List<TaskComment>? comment;

  @override
  String toString() {
    return toJson().toString();
  }

  TaskItemModel(
      {required this.id,
      required this.title,
      required this.content,
      required this.index,
      required this.type,
      required this.timeOut,
      required this.status,
      required this.assign,
      required this.attchaments,
      required this.comment,
      required this.completeAt,
      required this.level_id,
      required this.priority_id,
      required this.priority,
      required this.timeStart,
      required this.user_id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt});

  factory TaskItemModel.fromJson(Map<String, dynamic> json) =>
      _$TaskItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskItemModelToJson(this);
}

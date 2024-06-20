import 'package:demo_retrofit_api/models/task/task_attachments/task_attchaments.dart';
import 'package:demo_retrofit_api/models/task/task_details/task_details.dart';
import 'package:demo_retrofit_api/models/task/task_images/task_images.dart';
import 'package:demo_retrofit_api/models/task/task_sub/task_sub.dart';
import 'package:json_annotation/json_annotation.dart';
part 'task_model.g.dart';

@JsonSerializable()
class TaskModel {
  int id;
  String title;
  String content;
  int index;
  String type;
  DateTime timeOut;
  int status;
  @JsonKey(name: 'level_id')
  int levelId;
  @JsonKey(name: 'task_images')
  List<TaskImages>? taskImages;
  @JsonKey(name: 'task_attachments')
  List<TaskAttchaments>? taskAttchaments;
  @JsonKey(name: 'task_details')
  List<TaskDetails>? taskDetails;
  @JsonKey(name: 'task_sub')
  List<TaskSub>? taskSub;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'deleted_at')
  String? deletedAt;

  @override
  String toString() {
    return toJson().toString();
  }

  TaskModel(
      {required this.id,
      required this.title,
      required this.content,
      required this.index,
      required this.type,
      required this.timeOut,
      required this.status,
      required this.levelId,
      required this.taskImages,
      required this.taskAttchaments,
      required this.taskDetails,
      required this.taskSub,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt});

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}

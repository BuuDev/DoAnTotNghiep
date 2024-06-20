import 'package:json_annotation/json_annotation.dart';
part 'task_timekeep.g.dart';

@JsonSerializable()
class TaskTimeKeep {
  bool success;
  String message;
  List<TaskTimeKeepData> data;

  TaskTimeKeep({
    required this.success,
    required this.message,
    required this.data,
  });

  factory TaskTimeKeep.fromJson(Map<String, dynamic> json) =>
      _$TaskTimeKeepFromJson(json);

  Map<String, dynamic> toJson() => _$TaskTimeKeepToJson(this);
}

@JsonSerializable()
class TaskTimeKeepData {
  int id;
  int level_id;
  int user_id;
  String title;
  String content;
  int index;
  String type;
  String? timeStart;
  String? timeOut;
  int priority_id;
  int status;
  String complete_at;
  String created_at;
  String updated_at;

  TaskTimeKeepData({
    required this.id,
    required this.level_id,
    required this.user_id,
    this.timeOut,
    this.timeStart,
    required this.title,
    required this.type,
    required this.priority_id,
    required this.status,
    required this.complete_at,
    required this.content,
    required this.created_at,
    required this.updated_at,
    required this.index,
  });

  factory TaskTimeKeepData.fromJson(Map<String, dynamic> json) =>
      _$TaskTimeKeepDataFromJson(json);

  Map<String, dynamic> toJson() => _$TaskTimeKeepDataToJson(this);
}

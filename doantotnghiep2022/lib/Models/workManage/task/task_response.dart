import 'package:doantotnghiep/Models/workManage/task/task_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'task_response.g.dart';

@JsonSerializable()
class TaskResponse {
  bool success;
  String message;
  List<TaskModelDemo>? data;

  TaskResponse({
    required this.success,
    required this.message,
    required this.data,
  });
  @override
  String toString() {
    return toJson().toString();
  }

  factory TaskResponse.fromJson(Map<String, dynamic> json) =>
      _$TaskResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TaskResponseToJson(this);
}

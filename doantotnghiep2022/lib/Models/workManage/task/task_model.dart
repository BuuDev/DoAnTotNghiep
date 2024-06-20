import 'package:doantotnghiep/Models/workManage/task/task_item_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'task_model.g.dart';

@JsonSerializable()
class TaskModelDemo {
  int id;
  int work_id;
  String name;
  int index;
  int status;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'deleted_at')
  String? deletedAt;
  List<TaskItemModel> list_task;

  TaskModelDemo({
    required this.id,
    required this.work_id,
    required this.name,
    required this.index,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.list_task,
  });
  @override
  String toString() {
    return toJson().toString();
  }

  factory TaskModelDemo.fromJson(Map<String, dynamic> json) =>
      _$TaskModelDemoFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelDemoToJson(this);
}

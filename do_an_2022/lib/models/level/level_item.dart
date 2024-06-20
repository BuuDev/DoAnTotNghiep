import 'package:demo_retrofit_api/models/task/task_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'level_item.g.dart';

@JsonSerializable()
class LevelItem {
  int id;
  List<TaskModel>? listTask;
  LevelItem({required this.id, required this.listTask});
  @override
  String toString() {
    return toJson().toString();
  }

  factory LevelItem.fromJson(Map<String, dynamic> json) =>
      _$LevelItemFromJson(json);

  Map<String, dynamic> toJson() => _$LevelItemToJson(this);
}

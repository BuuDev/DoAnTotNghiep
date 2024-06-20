import 'package:json_annotation/json_annotation.dart';

import '../../task/task_item_model.dart';
part 'garbage.g.dart';

@JsonSerializable()
class GarbageModelResponse {
  bool success;
  String message;
  List<TaskItemModel>? data;

  GarbageModelResponse({
    required this.success,
    required this.message,
    required this.data,
  });
  @override
  String toString() {
    return toJson().toString();
  }

  factory GarbageModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GarbageModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GarbageModelResponseToJson(this);
}

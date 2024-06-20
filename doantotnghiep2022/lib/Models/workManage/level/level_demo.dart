import 'package:json_annotation/json_annotation.dart';

import 'level_item_demo.dart';
part 'level_demo.g.dart';

@JsonSerializable()
class LevelDemo {
  int id;
  @JsonKey(name: 'user_id')
  int userId;
  String? name;
  String? status;
  int? progress;
  String? type;
  String? priority;
  String? starting;
  String? ending;
  String? size;
  String? rate;
  String? detail;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  List<LevelItemDemo>? level;

  LevelDemo(
      {required this.id,
      required this.userId,
      required this.name,
      required this.status,
      required this.progress,
      required this.type,
      required this.priority,
      required this.starting,
      required this.ending,
      required this.size,
      required this.rate,
      required this.detail,
      required this.createdAt,
      required this.updatedAt,
      required this.level});
  @override
  String toString() {
    return toJson().toString();
  }

  factory LevelDemo.fromJson(Map<String, dynamic> json) =>
      _$LevelDemoFromJson(json);

  Map<String, dynamic> toJson() => _$LevelDemoToJson(this);
}

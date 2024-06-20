import 'package:json_annotation/json_annotation.dart';
part 'level_item_demo.g.dart';

@JsonSerializable()
class LevelItemDemo {
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

  LevelItemDemo(
      {required this.id,
      required this.work_id,
      required this.name,
      required this.index,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt});
  @override
  String toString() {
    return toJson().toString();
  }

  factory LevelItemDemo.fromJson(Map<String, dynamic> json) =>
      _$LevelItemDemoFromJson(json);

  Map<String, dynamic> toJson() => _$LevelItemDemoToJson(this);
}

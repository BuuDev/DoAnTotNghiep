import 'package:json_annotation/json_annotation.dart';
part 'level.g.dart';

@JsonSerializable()
class LevelModel {
  int id;
  String name;
  int index;
  int status;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'deleted_at')
  String? deletedAt;

  LevelModel(
      {required this.id,
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

  factory LevelModel.fromJson(Map<String, dynamic> json) =>
      _$LevelModelFromJson(json);

  Map<String, dynamic> toJson() => _$LevelModelToJson(this);
}

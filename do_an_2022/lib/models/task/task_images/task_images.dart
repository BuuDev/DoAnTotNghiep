import 'package:json_annotation/json_annotation.dart';
part 'task_images.g.dart';

@JsonSerializable()
class TaskImages {
  int id;
  String url;
  String type;
  String name;
  int status;

  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'deleted_at')
  String? deletedAt;

  TaskImages(
      {required this.id,
      required this.url,
      required this.type,
      required this.name,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt});

  @override
  String toString() {
    return toJson().toString();
  }

  factory TaskImages.fromJson(Map<String, dynamic> json) =>
      _$TaskImagesFromJson(json);

  Map<String, dynamic> toJson() => _$TaskImagesToJson(this);
}

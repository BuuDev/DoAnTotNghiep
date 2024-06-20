import 'package:json_annotation/json_annotation.dart';
part 'work.g.dart';

@JsonSerializable()
class WorkModel {
  int id;
  @JsonKey(name: 'user_id')
  int userId;
  String name;
  String? status;
  String? type;
  String? priority;
  DateTime? starting;
  DateTime? ending;
  String? size;
  String? rate;
  String? detail;
  String? background;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'deleted_at')
  String? deletedAt;

  WorkModel(
      {required this.id,
      required this.userId,
      required this.name,
      required this.status,
      required this.type,
      required this.priority,
      required this.starting,
      required this.ending,
      required this.size,
      required this.rate,
      required this.detail,
      required this.background,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt});

  factory WorkModel.fromJson(Map<String, dynamic> json) => _$WorkModelFromJson(json);

  Map<String, dynamic> toJson() => _$WorkModelToJson(this);
}

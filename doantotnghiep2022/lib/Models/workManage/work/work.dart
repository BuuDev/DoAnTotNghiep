import 'package:doantotnghiep/Models/workManage/userwork/user_work.dart';
import 'package:json_annotation/json_annotation.dart';
part 'work.g.dart';

@JsonSerializable()
class WorkModel {
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
  List<UserWork>? ds_user;

  WorkModel(
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
      required this.ds_user});
  @override
  String toString() {
    return toJson().toString();
  }

  factory WorkModel.fromJson(Map<String, dynamic> json) =>
      _$WorkModelFromJson(json);

  Map<String, dynamic> toJson() => _$WorkModelToJson(this);
}

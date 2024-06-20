import 'package:json_annotation/json_annotation.dart';
part 'user_work.g.dart';

@JsonSerializable()
class UserWork {
  int id;
  String code;
  String fullname;
  String username;
  String? birthday;
  String? citizen_identification;
  String? avatar;
  String email;
  String? phone;
  String? address;
  String? token;
  int role_id;
  int department_id;
  String? remember_token;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'deleted_at')
  String? deletedAt;
  Pivot pivot;
  @override
  String toString() {
    return toJson().toString();
  }

  UserWork(
      {required this.id,
      required this.code,
      required this.fullname,
      required this.username,
      required this.birthday,
      required this.citizen_identification,
      required this.avatar,
      required this.email,
      required this.phone,
      required this.address,
      required this.token,
      required this.role_id,
      required this.department_id,
      this.remember_token,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.pivot});

  factory UserWork.fromJson(Map<String, dynamic> json) =>
      _$UserWorkFromJson(json);

  Map<String, dynamic> toJson() => _$UserWorkToJson(this);
}

@JsonSerializable()
class Pivot {
  int work_id;
  int user_id;
  int id;

  Pivot({required this.work_id, required this.user_id, required this.id});

  factory Pivot.fromJson(Map<String, dynamic> json) => _$PivotFromJson(json);

  Map<String, dynamic> toJson() => _$PivotToJson(this);
}

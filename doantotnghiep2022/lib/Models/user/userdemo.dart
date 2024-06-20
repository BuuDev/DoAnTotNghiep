import 'package:json_annotation/json_annotation.dart';
part 'userdemo.g.dart';

@JsonSerializable()
class User {
  int id;
  String name;
  String username;
  @JsonKey(name: 'email')
  String email;
  String? avatar;
  @JsonKey(name: 'role_id')
  int? roleId;
  @JsonKey(name: 'nationality_id')
  int? nationnalityId;
  String password;
  String token;
  String opt;
  @JsonKey(name: 'expired_time')
  DateTime? expiredTime;
  int? activel;
  @JsonKey(name: 'google_id')
  String? googleId;
  int? status;
  String? phone;
  String? provider;
  @JsonKey(name: 'expired_time_otp')
  DateTime? expiredTimeOtp;
  @JsonKey(name: 'last_login')
  DateTime? lasteLogin;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'deleted_at')
  String? deletedAt;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.avatar,
    required this.roleId,
    required this.nationnalityId,
    required this.password,
    required this.token,
    required this.opt,
    required this.expiredTime,
    required this.activel,
    required this.googleId,
    required this.status,
    required this.phone,
    required this.provider,
    required this.expiredTimeOtp,
    required this.lasteLogin,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });
  
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

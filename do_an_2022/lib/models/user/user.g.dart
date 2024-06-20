// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String?,
      roleId: json['role_id'] as int?,
      nationnalityId: json['nationality_id'] as int?,
      password: json['password'] as String,
      token: json['token'] as String,
      opt: json['opt'] as String,
      expiredTime: json['expired_time'] == null
          ? null
          : DateTime.parse(json['expired_time'] as String),
      activel: json['activel'] as int?,
      googleId: json['google_id'] as String?,
      status: json['status'] as int?,
      phone: json['phone'] as String?,
      provider: json['provider'] as String?,
      expiredTimeOtp: json['expired_time_otp'] == null
          ? null
          : DateTime.parse(json['expired_time_otp'] as String),
      lasteLogin: json['last_login'] == null
          ? null
          : DateTime.parse(json['last_login'] as String),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'avatar': instance.avatar,
      'role_id': instance.roleId,
      'nationality_id': instance.nationnalityId,
      'password': instance.password,
      'token': instance.token,
      'opt': instance.opt,
      'expired_time': instance.expiredTime?.toIso8601String(),
      'activel': instance.activel,
      'google_id': instance.googleId,
      'status': instance.status,
      'phone': instance.phone,
      'provider': instance.provider,
      'expired_time_otp': instance.expiredTimeOtp?.toIso8601String(),
      'last_login': instance.lasteLogin?.toIso8601String(),
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };

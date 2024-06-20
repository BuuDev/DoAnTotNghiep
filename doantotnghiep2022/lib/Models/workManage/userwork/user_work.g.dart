// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_work.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWork _$UserWorkFromJson(Map<String, dynamic> json) => UserWork(
      id: json['id'] as int,
      code: json['code'] as String,
      fullname: json['fullname'] as String,
      username: json['username'] as String,
      birthday: json['birthday'] as String?,
      citizen_identification: json['citizen_identification'] as String?,
      avatar: json['avatar'] as String?,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      token: json['token'] as String?,
      role_id: json['role_id'] as int,
      department_id: json['department_id'] as int,
      remember_token: json['remember_token'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
      pivot: Pivot.fromJson(json['pivot'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserWorkToJson(UserWork instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'fullname': instance.fullname,
      'username': instance.username,
      'birthday': instance.birthday,
      'citizen_identification': instance.citizen_identification,
      'avatar': instance.avatar,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'token': instance.token,
      'role_id': instance.role_id,
      'department_id': instance.department_id,
      'remember_token': instance.remember_token,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
      'pivot': instance.pivot,
    };

Pivot _$PivotFromJson(Map<String, dynamic> json) => Pivot(
      work_id: json['work_id'] as int,
      user_id: json['user_id'] as int,
      id: json['id'] as int,
    );

Map<String, dynamic> _$PivotToJson(Pivot instance) => <String, dynamic>{
      'work_id': instance.work_id,
      'user_id': instance.user_id,
      'id': instance.id,
    };

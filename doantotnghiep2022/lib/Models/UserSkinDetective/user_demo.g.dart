// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_demo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDemo _$UserDemoFromJson(Map<String, dynamic> json) => UserDemo(
      email: json['email'] as String?,
      avatar: json['avatar'] as String?,
      id: json['id'] as int?,
      fullname: json['fullname'] as String?,
      address: json['address'] as String?,
      birthday: json['birthday'] as String?,
      citizenIdentification: json['citizen_identification'] as String?,
      code: json['code'] as String?,
      departmentId: json['department_id'] as int?,
      phone: json['phone'] as String?,
      roleId: json['role_id'] as int?,
      username: json['username'] as String?,
      role: json['role'] == null
          ? null
          : RoleUser.fromJson(json['role'] as Map<String, dynamic>),
      department: json['department'] == null
          ? null
          : Department.fromJson(json['department'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDemoToJson(UserDemo instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'fullname': instance.fullname,
      'username': instance.username,
      'birthday': instance.birthday,
      'citizen_identification': instance.citizenIdentification,
      'avatar': instance.avatar,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'role_id': instance.roleId,
      'department_id': instance.departmentId,
      'role': instance.role,
      'department': instance.department,
    };

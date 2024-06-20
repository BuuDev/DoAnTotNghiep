// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_get_list_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseListUser _$ResponseListUserFromJson(Map<String, dynamic> json) =>
    ResponseListUser(
      user: UserResponse.fromJson(json['user'] as Map<String, dynamic>),
      department: (json['department'] as List<dynamic>)
          .map((e) => Department.fromJson(e as Map<String, dynamic>))
          .toList(),
      role: (json['role'] as List<dynamic>)
          .map((e) => RoleUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseListUserToJson(ResponseListUser instance) =>
    <String, dynamic>{
      'user': instance.user,
      'role': instance.role,
      'department': instance.department,
    };

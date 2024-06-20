// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_role_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListRoleData _$ListRoleDataFromJson(Map<String, dynamic> json) => ListRoleData(
      role: (json['role'] as List<dynamic>)
          .map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList(),
      permission: (json['permission'] as List<dynamic>)
          .map((e) => Permisstion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListRoleDataToJson(ListRoleData instance) =>
    <String, dynamic>{
      'role': instance.role,
      'permission': instance.permission,
    };

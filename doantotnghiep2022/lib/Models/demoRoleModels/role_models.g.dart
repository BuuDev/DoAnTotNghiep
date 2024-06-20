// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Roles _$RolesFromJson(Map<String, dynamic> json) => Roles(
      id: json['id'] as int,
      title: json['title'] as String,
      listRoles:
          (json['listRoles'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RolesToJson(Roles instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'listRoles': instance.listRoles,
    };
